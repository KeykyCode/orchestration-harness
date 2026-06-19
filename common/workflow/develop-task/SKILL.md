---
name: develop-task
description: 태스크명(태그 포함)을 받아 현 프로젝트 conventions의 레이어 규칙대로 코드를 생성하고 타입체크 후 태스크 상태를 갱신할 때 사용. "[Page]/[API]/[Action]… 구현해줘"에 발동. 디자인은 design-system, 데이터·인증은 횡단 모듈을 따른다.
---

# Develop Task (스택 중립)

## 먼저 읽기
- `CLAUDE.md`, `.tasks/backlog.md`, `.tasks/design/`
- **현 프로젝트 conventions 스킬** — 태그→구현위치, 레이어 규칙, 패턴 (**1순위 기준**)
- 관련 횡단 모듈 — `api-client`/`tanstack-query`(데이터), `supabase-auth`(인증), `design-system`(UI)
- 같은 도메인 기존 코드 — 패턴 일관성

## 구현 규칙 (자주 틀리는 지점)
1. 태스크 **태그**로 구현 위치 판단(conventions의 태그표).
2. 그 레이어 규칙대로 작성:
   - 서버 데이터 = Query 훅 / Next 서버컴포넌트·Server Action. **`useEffect` 수동 페칭·Zustand 저장 금지.**
   - 호출은 **`apiClient` 경유**(날것 fetch 금지).
   - Zustand는 **클라 UI 전역만**.
   - 인증 판단은 **서버 기준**(클라 불린 금지).
3. UI면 **design-system 토큰·컴포넌트**(하드코딩 HEX/임시 클래스 금지, 스펙 있는 컴포넌트 재사용).

## 검증·기록
- `npx tsc --noEmit`(오류 즉시 수정)
- `.tasks/backlog.md` `- [ ]`→`- [x]`, `.tasks/in-progress.md`에 완료내역
- 요약 + 다음 태스크 안내
