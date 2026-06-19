---
name: design-system
description: UI 화면·컴포넌트를 설계하거나 구현할 때 사용. 같은 폴더의 DESIGN.md(토큰명·역할·컴포넌트 스펙)와 tokens.md(실제 색값)를 디자인 Source of Truth로 적용한다. 색/spacing/radius 하드코딩을 막고 기존 컴포넌트를 재사용시킨다. 스택(Vite/Next) 무관 공통.
---

# Design System (사용 규칙)

UI를 만들거나 설계하기 전에 **반드시 이 모듈의 두 파일을 읽어라.**

- **`DESIGN.md`** — 토큰 **이름·역할**, 컴포넌트 스펙(Buttons·Inputs·Select·Chips/Status·Checkbox·Sidebar·Modal·Dropdown/Tooltip·System States), 타이포·spacing·radius·z-index, Tone & Voice. **구조는 회사 공용, 수정 금지.**
- **`tokens.md`** — 실제 색값(OKLCH). **프로젝트별 컬러톤** → 프로젝트에 복사한 뒤 그 프로젝트에 맞게 교체한다.

## 적용 규칙 (위반 자주 발생 → 반드시 점검)

1. **색은 시맨틱 토큰만.** 하드코딩 HEX·임의 Tailwind 색(`text-gray-500` 등) 금지 → `DESIGN.md`의 토큰(`--primary`, `bg-grey-50`, `text-foreground` 등) 사용.
2. **spacing·radius·shadow·z-index**도 토큰/스케일만. 임의 px 금지.
3. **컴포넌트는 재사용.** `DESIGN.md`에 스펙이 있는 컴포넌트(버튼·인풋·Select·칩·체크박스·모달·툴팁 등)는 **새로 만들지 말고** 그 스펙대로 구현/재사용. 없는 패턴은 임의 생성 말고 먼저 제안.
4. **Tone & Voice**: 문구는 명료함 우선, 전문적이되 친근, 명령 대신 안내 (`DESIGN.md` 톤 표 따름).
5. **다크모드 임의 생성 금지** — `DESIGN.md`는 Light 기준. 다크 토큰값을 지어내지 마라(필요 시 별도 정의 선행).

## 프로젝트 적용 (컬러톤)

`tokens.md`는 **중립 기본값(검정 무채색)**으로 보관한다. 프로젝트에 복사한 뒤:
- 시드 컬러가 있으면 → 그 색을 Primary(`--color-blue-*` 슬롯)·Secondary(`--color-violet-*` 슬롯)로 OKLCH 스케일 생성.
- 회사 디자인 시스템 export가 있으면 → 그 값으로 교체.
- 기능 색(red/green/yellow/mint/orange)은 상태 가독성 때문에 유지.

> 화면은 CSS 변수(`var(--primary)` 등)만 쓰므로 **`tokens.md`만 갈아끼우면 전체 톤이 자동 반영**된다.

> ⚠️ 이 모듈의 `tokens.md`는 **공용 마스터의 중립값**이다. 특정 프로젝트 색으로 이 마스터를 덮어쓰지 마라 — 색 교체는 항상 *프로젝트로 복사한 사본*에서 한다.
