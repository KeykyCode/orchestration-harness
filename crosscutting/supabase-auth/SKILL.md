---
name: supabase-auth
description: Supabase 인증을 붙일 때 사용. 서버사이드 세션(쿠키)·미들웨어 갱신·RLS 기반 보호 패턴을 적용한다. "클라이언트 불린 하나로 인증 판단", "앱 레벨 체크에만 의존" 같은 취약 패턴을 금지시킨다. Next(@supabase/ssr) 우선, Vite SPA 변형 포함.
---

# Supabase Auth (서버사이드 기준)

## 핵심 원칙 (보안 — 절대 타협 금지)

1. **인증 판단의 기준은 서버다.** 클라이언트 불린(`isAuthenticated`) 하나로 보호 화면을 가르지 마라. 새로고침에 날아가고 위조 가능.
2. **데이터 보호는 RLS(Row Level Security)로.** "프론트에서 안 보여주니 안전"은 보안이 아니다. 테이블마다 RLS 정책을 건다.
3. **민감정보는 서버에서만 접근.** 서비스 롤 키는 절대 클라이언트 번들에 넣지 않는다(서버 전용).

## Next (App Router) — `@supabase/ssr`

- **클라이언트 분리**: 브라우저용(`createBrowserClient`)과 서버용(`createServerClient`, 쿠키 연동)을 분리해 만든다.
- **미들웨어에서 세션 갱신**: 모든 요청에서 토큰을 리프레시해 쿠키에 다시 심는다.
- **보호 라우트는 서버에서**: 서버컴포넌트/레이아웃에서 `supabase.auth.getUser()`로 확인 후 미인증이면 `redirect('/login')`.

```ts
// middleware.ts (핵심 — 세션 갱신 + 미인증 보호)
import { createServerClient } from '@supabase/ssr'
import { NextResponse, type NextRequest } from 'next/server'

export async function middleware(request: NextRequest) {
  let response = NextResponse.next({ request })
  const supabase = createServerClient(URL, ANON_KEY, {
    cookies: {
      getAll: () => request.cookies.getAll(),
      setAll: (cookies) => cookies.forEach(({ name, value, options }) =>
        response.cookies.set(name, value, options)),
    },
  })
  const { data: { user } } = await supabase.auth.getUser() // 세션 갱신
  if (!user && request.nextUrl.pathname.startsWith('/app')) {
    return NextResponse.redirect(new URL('/login', request.url))
  }
  return response
}
export const config = { matcher: ['/((?!_next/static|_next/image|favicon.ico).*)'] }
```

> `getUser()`를 써라(서버에서 토큰 재검증). `getSession()`은 쿠키 신뢰라 서버 보호 판단엔 약하다.

## Vite SPA 변형

- `supabase-js` 브라우저 클라이언트 + `onAuthStateChange`로 세션 구독, 토큰은 Supabase가 관리.
- 라우트 가드는 UX용(접근 차단 느낌)일 뿐, **실제 보호는 RLS**가 한다. 가드 통과 ≠ 데이터 접근 허용.

## 공통

- 가짜 이메일 스킴·소셜 로그인 등 프로젝트별 방식은 그 프로젝트 컨벤션에 기록.
- 로그인/로그아웃/세션 만료(401) 흐름은 `api-client`의 401 처리와 연결한다.
