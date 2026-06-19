---
name: next-conventions
description: Next.js(App Router) 프로젝트를 새로 만들거나 화면·기능을 추가할 때 사용. 서버/클라이언트 컴포넌트 구분·Server Actions·폴더구조·라우팅·셋업 컨벤션을 적용한다. SEO/공개 콘텐츠가 중요할 때 기본 선택. 인증·디자인·서버상태는 횡단 모듈에 위임한다.
---

# Next.js (App Router) Conventions

> 적용 전 함께 읽을 모듈: `supabase-auth`(인증·미들웨어), `design-system`(UI), 클라이언트 페칭이 필요하면 `tanstack-query`.
> SEO가 불필요한 로그인 뒤 툴이라면 `vite-react-conventions`가 더 가벼울 수 있다(`setup` 참조).

## 셋업

```bash
npx create-next-app@latest <name> --typescript --app --tailwind --src-dir --eslint
cd <name>
npm i @supabase/ssr @supabase/supabase-js
npx shadcn@latest init      # shadcn/ui는 CLI로
# 클라이언트 페칭이 필요하면: npm i @tanstack/react-query
```
- `tokens.md`를 프로젝트로 복사해 컬러톤 적용(`design-system`). 색은 `app/globals.css`에 `@theme`/`:root`로.
- 인증은 `middleware.ts` + 서버/브라우저 Supabase 클라이언트 분리(`supabase-auth`).

## 폴더 구조

```
src/
├── app/
│   ├── (public)/       # 랜딩·블로그 등 공개 (SEO 대상)
│   ├── (app)/          # 로그인 뒤 보호 영역
│   ├── api/            # Route Handlers (웹훅·외부 콜백 등 필요할 때만)
│   ├── layout.tsx · page.tsx
│   └── globals.css
├── components/         # ui/(shadcn) + 도메인 컴포넌트
├── actions/            # Server Actions (서버 변경 로직)
├── lib/
│   └── supabase/       # server.ts / client.ts (분리)
├── queries/            # (클라 페칭 필요 시) tanstack-query
├── stores/             # Zustand — 클라 UI 전역만
├── types/
└── middleware.ts       # 세션 갱신 + 보호 (supabase-auth)
```

## 서버/클라이언트 컴포넌트 (가장 자주 틀림)

- **기본은 서버 컴포넌트.** 데이터는 서버 컴포넌트에서 **직접 조회**(Supabase 서버 클라이언트). 클라 페칭 보일러플레이트 불필요.
- `'use client'`는 **상호작용이 있을 때만**(상태·이벤트 핸들러·브라우저 API). 가능한 **잎(leaf)에 가깝게**, 트리 상단에 붙이지 마라.
- 서버 컴포넌트에서 서버 전용 비밀(서비스 키 등)을 다루고, 클라 컴포넌트엔 직렬화 가능한 props만 내린다.

## 데이터 흐름

| 작업 | 방법 |
|---|---|
| 조회(read) | **서버 컴포넌트에서 직접** (Supabase server client) |
| 변경(write) | **Server Actions**(`actions/`) + `revalidatePath`/`revalidateTag` |
| 클라 상호작용 데이터 | 무한스크롤·낙관적 업데이트 등만 `tanstack-query` |
| 외부 웹훅/콜백 | `app/api/*/route.ts`(Route Handler) |

## 인증·보호

- `middleware.ts`에서 세션 갱신, 보호 영역은 서버에서 `getUser()` 확인 후 `redirect`(`supabase-auth`).
- 데이터 보호는 **RLS**. 미들웨어/레이아웃 가드는 UX 보조.

## 명명·라우팅

- 라우트는 `app/.../page.tsx`(폴더=경로), `layout.tsx`(공통), `loading.tsx`/`error.tsx`(상태). route group `(name)`은 URL에 안 들어감.
- 컴포넌트 PascalCase, Server Action 동사형(`createUser`).

## 새 기능 추가 순서

`types/` → (조회는 서버 컴포넌트에서 직접 / 변경은 `actions/`) → `app/.../page.tsx`(서버) → 상호작용 필요 시 `'use client'` 컴포넌트 분리 → 보호는 `middleware`/레이아웃.

## 태스크 태그 (workflow와 연동)

`[Type]` `[Data]`(서버 조회) `[Action]`(Server Action) `[Page]`(서버 컴포넌트) `[Client]`(`'use client'`) `[Route]`(Route Handler) `[Middleware]`

## 검증

`npx tsc --noEmit` · `npm run build` · (테스트 도입 시 Vitest/Playwright).
