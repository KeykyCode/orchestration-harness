---
name: api-client
description: REST API를 fetch로 호출하는 클라이언트 레이어를 만들 때 사용. 인증 헤더 주입·통일된 에러 처리·401 자동 로그아웃을 포함한 fetch 래퍼 패턴을 적용한다. 날것 fetch 대신 이 래퍼를 쓰게 한다. Vite/Next 클라이언트 공통.
---

# API Client (fetch 래퍼)

**날것 `fetch('/api/...')`를 화면·API 함수에 직접 쓰지 마라.** 아래 단일 래퍼를 거치게 한다. 이유: 인증 헤더·baseURL·에러 형태·401 처리를 한 곳에서 통일해야 함.

## 판단 기준

- 모든 서버 호출은 `apiClient`를 통한다. API 함수(`api/*.ts`)는 `apiClient`만 호출하는 얇은 래퍼다.
- 에러는 `ApiError`(status 포함)로 통일 → 호출부/Query에서 status로 분기.
- **401은 래퍼에서 자동 로그아웃** 처리(토큰 만료 일괄 대응). 화면마다 처리하지 않는다.
- 토큰 저장 위치는 프로젝트 인증 방식에 따른다(Vite: 안전 저장소 / Next: 쿠키·세션은 `supabase-auth` 참조).

## 표준 구현 (이 보일러플레이트는 통짜로 유지)

```ts
// src/lib/apiClient.ts
const BASE_URL = import.meta.env.VITE_API_BASE_URL ?? '' // Next: process.env.NEXT_PUBLIC_API_BASE_URL

export class ApiError extends Error {
  constructor(public status: number, message: string, public body?: unknown) {
    super(message)
    this.name = 'ApiError'
  }
}

function getToken(): string | null {
  // 프로젝트 인증 방식에 맞게 연결 (Zustand authStore / 쿠키 등)
  return null
}

export async function apiClient<T>(path: string, options: RequestInit = {}): Promise<T> {
  const token = getToken()
  const res = await fetch(`${BASE_URL}${path}`, {
    ...options,
    headers: {
      'Content-Type': 'application/json',
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
      ...options.headers,
    },
  })

  if (!res.ok) {
    if (res.status === 401) {
      // 토큰 만료 → 로그아웃 일괄 처리 (프로젝트 authStore.logout() 연결)
    }
    const body = await res.json().catch(() => res.statusText)
    throw new ApiError(res.status, typeof body === 'string' ? body : (body?.message ?? '요청 실패'), body)
  }

  return res.status === 204 ? (undefined as T) : res.json()
}
```

## API 함수 패턴 (얇게)

```ts
// src/api/userApi.ts
import { apiClient } from '@/lib/apiClient'
import type { User, CreateUserInput } from '@/types/user'

export const fetchUserList = () => apiClient<User[]>('/api/users')
export const createUser = (input: CreateUserInput) =>
  apiClient<User>('/api/users', { method: 'POST', body: JSON.stringify(input) })
```

> 이 API 함수들은 **순수 호출만** 한다(상태 변경 없음). 캐싱·로딩·리페치는 `tanstack-query`(또는 Next RSC)가 담당한다.
