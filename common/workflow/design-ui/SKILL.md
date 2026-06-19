---
name: design-ui
description: 화면명을 받아 ASCII 와이어프레임·컴포넌트 트리·상태 설계를 만들고 .tasks/design/에 저장할 때 사용. "화면 설계", "UI 구조", "와이어프레임"에 발동. design-system 토큰·컴포넌트를 재사용하고 서버/클라 상태를 구분해 설계한다.
---

# Design UI (스택 중립)

## 먼저 읽기
- `CLAUDE.md`, `.tasks/backlog.md`
- **`design-system`** (DESIGN.md 토큰·컴포넌트·톤, tokens.md 색값) — UI의 Source of Truth
- 현 프로젝트 **conventions** — 폴더구조/컴포넌트 배치 기준

## 산출
1. **ASCII 와이어프레임** (레이아웃)
2. **컴포넌트 트리** — conventions의 폴더구조 기준 (Next면 서버/클라 컴포넌트 구분 표시)
3. **상태 설계** — 반드시 구분:
   - **서버 상태** → Query 훅 / Next 서버컴포넌트·Server Action
   - **전역 클라 상태** → Zustand (UI 전역만)
   - **화면 전용** → `useState`
4. **데이터 흐름** (조회/변경 경로)
5. `.tasks/design/<화면>.md`로 저장

## 디자인 준수
색·spacing·radius는 토큰만(하드코딩 금지), `DESIGN.md`에 있는 컴포넌트는 재사용, 없으면 제안. 문구는 DESIGN.md 톤.

## 다음
`/develop-task "[첫 태그] <화면> …"`
