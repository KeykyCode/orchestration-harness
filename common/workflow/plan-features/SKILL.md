---
name: plan-features
description: 기능/프로젝트 설명을 받아 화면 구조·레이어별 태스크·우선순위로 분해하고 .tasks/backlog.md에 기록할 때 사용. "기능 기획", "태스크 분해", "뭐부터 만들지"에 발동. 스택 무관 — 태스크 태그는 현 프로젝트의 conventions 스킬 체계를 따른다.
---

# Plan Features (스택 중립)

## 먼저 읽기
- `CLAUDE.md`, `.tasks/backlog.md` — 기존 컨텍스트
- **현 프로젝트의 conventions 스킬**(`vite-react-conventions` / `next-conventions` 등) — **태스크 태그 체계**를 여기서 가져온다

## 산출
1. **화면/메뉴 계층 구조** (트리)
2. **레이어별 태스크 분해** — 태그는 conventions를 따름:
   - Vite: `[Type] [API] [Query] [Store] [Page] [Component] [Route]`
   - Next: `[Type] [Data] [Action] [Page] [Client] [Route] [Middleware]`
   - 각 태스크는 2~4시간 단위.
3. **우선순위** P0(핵심)/P1(중요)/P2(부가)
4. `.tasks/backlog.md`에 기록:

```md
## [기능명] — YYYY-MM-DD 등록
### 📱 화면/메뉴 구조
### 📋 태스크 목록
#### P0 — 핵심
- [ ] [태그] 설명 | 1h
```

## 다음
전체 예상 시간·권장 순서 출력 → 첫 화면 `/design-ui "화면명"`.
