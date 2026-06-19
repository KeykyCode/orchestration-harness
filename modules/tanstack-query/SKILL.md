---
name: tanstack-query
description: 서버 데이터의 페칭·캐싱·갱신을 다룰 때 사용. TanStack Query로 쿼리키 팩토리·useQuery/useMutation 훅·invalidate 패턴을 적용한다. useEffect+useState 수동 페칭과 "서버데이터를 Zustand에 저장"을 금지시킨다. Vite SPA 기본, Next는 클라이언트 페칭이 필요한 곳에 사용.
---

# TanStack Query (서버 상태)

## 핵심 원칙 (자주 틀리는 지점)

1. **서버 데이터 = Query.** `useEffect`+`useState`로 수동 페칭하지 마라. 서버 데이터를 **Zustand에 넣지 마라**(전역 클라 상태 ≠ 서버 캐시).
2. **레이어**: `api/`(순수 호출, `api-client` 참조) → `queries/`(Query 훅) → `pages/components`(훅만 사용). 페이지는 fetch·로딩 플래그를 직접 만들지 않는다.
3. **쿼리키는 팩토리로** 관리(중복/오타 방지, invalidate 일관성).
4. **변경(mutation) 후 `invalidateQueries`**로 관련 캐시 무효화.

## 패턴 (핵심만)

```ts
// src/queries/userQueries.ts
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { fetchUserList, createUser } from '@/api/userApi'

export const userKeys = {
  all: ['users'] as const,
  list: () => [...userKeys.all, 'list'] as const,
  detail: (id: number) => [...userKeys.all, 'detail', id] as const,
}

export function useUserList() {
  return useQuery({ queryKey: userKeys.list(), queryFn: fetchUserList })
}

export function useCreateUser() {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: createUser,
    onSuccess: () => qc.invalidateQueries({ queryKey: userKeys.all }),
  })
}
```

```tsx
// 페이지에서 — 로딩/에러는 Query가 준다 (수동 상태 없음)
const { data: users = [], isLoading, isError } = useUserList()
const { mutate: create, isPending } = useCreateUser()
if (isLoading) return <LoadingState />
if (isError) return <ErrorState />
```

## Provider 셋업

```tsx
const queryClient = new QueryClient({
  defaultOptions: { queries: { staleTime: 60_000, retry: 1 } },
})
// 앱 루트를 <QueryClientProvider client={queryClient}> 로 감싼다
```

## 스택별 위치

- **Vite SPA**: 모든 서버 데이터의 기본 수단.
- **Next (App Router)**: 1순위는 **서버컴포넌트 직접 조회**. Query는 *클라이언트 상호작용이 필요한 데이터*(무한스크롤·낙관적 업데이트·실시간 갱신)에만. 서버에서 prefetch 후 `HydrationBoundary`로 전달 가능.

> 테스트는 `api/` 함수 단위 테스트 + Query 훅은 `QueryClientProvider` 래퍼로 렌더 테스트.
