---
name: ts-vite-react
description: Vite + React(SPA) 프로젝트를 새로 만들거나 화면·기능을 추가할 때 사용. 폴더구조·파일 라우팅(TanStack Router)·레이어·명명·셋업 컨벤션을 적용한다. SEO가 불필요한 로그인 뒤 대시보드/툴에 적합. 서버상태·인증·디자인은 횡단 모듈에 위임한다.
---

# Vite + React (SPA) Conventions

> 적용 전 함께 읽을 모듈: `tanstack-query`(서버상태), `api-client`(fetch), `design-system`(UI), `supabase-auth`(인증 시).
> SEO가 필요하면 이 스택이 아니라 `ts-next`를 검토하라(`setup`이 질문으로 안내).

## 셋업

```bash
npm create vite@latest <name> -- --template react-ts && cd <name>
npm i zustand @tanstack/react-router @tanstack/react-query
npm i -D @tanstack/router-plugin vitest @testing-library/react @testing-library/user-event @testing-library/jest-dom jsdom @types/node
npx shadcn@latest init      # shadcn/ui는 CLI로 (수동 생성 금지)
```
- `vite.config.ts`: `@` alias(`src`), `TanStackRouterVite`, `@tailwindcss/vite`, vitest(jsdom).
- 앱 루트를 `QueryClientProvider`로 감싼다(`tanstack-query`).
- `tokens.md`를 프로젝트로 복사해 컬러톤 적용(`design-system`).

## 폴더 구조

```
src/
├── routes/       # TanStack Router 파일 기반 (__root, _authenticated/…)
├── pages/        # 페이지 — Query 훅만 사용, fetch·로딩플래그 직접 X
├── components/   # 재사용 컴포넌트 (ui/ = shadcn)
├── api/          # 순수 호출 (apiClient만) — api-client 참조
├── queries/      # TanStack Query 훅 — tanstack-query 참조
├── stores/       # Zustand — 클라 UI 전역상태만 (서버데이터 X)
├── lib/          # apiClient, utils(cn)
└── types/        # 타입/인터페이스
```

## 레이어 규칙 (단방향)

```
types → api(apiClient) → queries(Query 훅) → pages/components
stores(Zustand) = 모달·필터·인증토큰 등 클라 UI 전역만
```
- 서버 데이터는 `queries/`(Query). **Zustand·useEffect 수동 페칭 금지**(`tanstack-query`).
- API 함수는 순수 — `apiClient`만 호출(`api-client`).

## 라우팅 (TanStack Router 파일 기반)

- `src/routes/`에 파일 추가 → 자동 라우트. `routeTree.gen.ts`는 자동생성(수정 금지).
- 보호 라우트는 `_authenticated/` 하위. 단 **실제 보호는 서버/RLS**가 한다(`supabase-auth`).

## 명명 규칙

| 대상 | 규칙 | 예 |
|---|---|---|
| 컴포넌트/페이지 | PascalCase | `UserCard.tsx`, `UserListPage.tsx` |
| Query 훅 | `useXxx` | `useUserList.ts` |
| 스토어 | `useXxxStore` | `useAuthStore.ts` |
| API 함수 | camelCase | `fetchUserList` |

## 새 기능 추가 순서

`types/` → `api/` → `queries/` → `pages/`·`components/` → `routes/`

## 태스크 태그 (workflow와 연동)

`[Type]` `[API]` `[Query]` `[Store]` `[Page]` `[Component]` `[Route]`
- `[Query]` = `queries/` Query 훅, `[Store]` = Zustand(클라 UI만).

## 검증

`npx tsc --noEmit` · `npm test`(Vitest) · `npm run build`.
