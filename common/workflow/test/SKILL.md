---
name: test
description: 대상 파일/기능의 단위·컴포넌트·시나리오 테스트를 작성하고 실행할 때 사용. "테스트 작성/실행"에 발동. 테스트 스택은 현 프로젝트 conventions를 따른다(기본 Vitest + Testing Library).
---

# Test (스택 중립)

## 먼저 읽기
현 프로젝트 **conventions**의 테스트 스택·패턴 확인 (기본: Vitest + Testing Library).

## 작성 우선순위
1. **api/ 함수** — `apiClient` mock 기반 단위 테스트(정상/에러)
2. **Query 훅** — `QueryClientProvider` 래퍼로 렌더, 성공/로딩/에러
3. **컴포넌트** — 렌더 + 인터랙션(`userEvent`)
4. **시나리오** — 페이지 전체 흐름 (given/when/then)

테스트 파일은 대상과 같은 디렉토리에 `.test.ts(x)`.

## 실행·보고
- 실행(`npm test` 등) → `✅ 통과 N / ❌ 실패 N` + 실패 원인
- 실패: 코드 버그 → 즉시 수정 / 설계 불일치 → `/design-ui` 재설계 권장
- 전체 통과 → `.tasks/in-progress.md` → `.tasks/done.md` 이동
