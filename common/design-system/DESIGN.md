# Design System Spec v2.0 (회사 공용)

> **목적**: AI/에이전트가 읽고 화면을 구현할 때 참조하는 **회사 공용 디자인 시스템 명세**.
> **Source of Truth**: 프론트엔드 `src/global.css` (CSS 변수 원본).
> **색상 실값**: 본 문서는 **토큰명 + 용도** 중심이다. HEX/OKLCH 실값은 [tokens.md](design-system/tokens.md)를 참조한다 (코드 1:1).
> **모드**: Light 기준. Dark(`.dark`)는 현재 shadcn 기본 그레이스케일 상태이며 브랜드 컬러 미적용(아래 [Dark Mode](#dark-mode) 참조).

이 문서는 **코드에 실제로 존재하는 토큰·컴포넌트만** 기록한다. 코드에 없는 항목(예: ExtraBold 800 weight, `--shadow-sm/md/lg` 토큰)은 포함하지 않는다.

---

## 목차

**Overview**

**Design Principles**
- [Tone & Voice](#tone--voice)

**Foundation**
- [Color — Raw Palette](#color--raw-palette)
- [Color — Semantic Tokens](#color--semantic-tokens)
- [Typography](#typography)
- [Icon System](#icon-system)
- [Spacing](#spacing)
- [Layout & Composition](#layout--composition)
- [Radius](#radius)
- [Shadow](#shadow)
- [Z-Index](#z-index)
- [Interaction](#interaction)

**Components**
- [Buttons](#buttons)
- [Inputs](#inputs)
- [Chips & Status](#chips--status)
- [Form Controls](#form-controls)
- [Navigation](#navigation)
- [Overlays](#overlays)
- [System States](#system-states)
- [Dark Mode](#dark-mode)
- [Component Inventory](#component-inventory)

**Do’s and Don’ts**

---


## Overview

키키코드는 기술이 더 많은 사람에게 쉽고 편리하게 다가갈 때 비로소 가치가 만들어진다고 믿는다. “좋은 코드로 행복한 세상을”이라는 슬로건은 단순한 개발 철학이 아니라, 제품 경험 전반에 반영되는 디자인 원칙이다.

키키코드의 디자인은 **기능성과 친근함 사이의 균형** 위에서 만들어진다.
개발 회사 특유의 논리적 구조와 명확한 정보 체계를 기반으로 하되, 화면은 지나치게 기술적이거나 딱딱하게 느껴지지 않아야 한다. 복잡한 기능도 부담 없이 탐색할 수 있도록 충분한 여백과 직관적인 흐름, 부드러운 형태와 가벼운 인터랙션을 사용한다. 사용자는 시스템을 배우고 있다는 느낌 대신 자연스럽게 익숙해지는 경험을 하게 된다.

시각적으로는 안정감 있는 생산성 툴의 구조를 기반으로 한다.
중립적인 베이스 컬러와 명확한 계층 구조를 통해 정보의 흐름을 정돈하며, 포인트 컬러와 인터랙션은 필요한 순간에만 가볍게 사용한다. 컬러와 모션, 그래픽 요소는 기능을 과장하기 위한 장식이 아니라, 사용자의 이해와 몰입을 돕기 위한 방향으로 활용된다.

동시에 키키코드는 기술 회사다운 유연함과 유쾌함을 잃지 않는다.
작은 애니메이션, 부드러운 라운드, 친근한 그래픽 요소, 가벼운 마이크로 인터랙션을 통해 화면 곳곳에 사람다운 온도를 남긴다. 인터페이스는 전문적이지만 긴장되지 않고, 체계적이지만 차갑지 않다. 사용자는 제품을 사용하는 동안 “복잡한 시스템을 다루고 있다”기보다, “똑똑한 도구와 함께 일하고 있다”는 인상을 받게 된다.

키키코드의 디자인 시스템은 결국 하나의 방향을 지향한다.
좋은 기술을 더 쉽고, 더 친근하고, 더 즐겁게 경험하게 만드는 것. 그리고 복잡한 기술 뒤에 있는 '사람의 경험'을 가장 중요하게 생각하는 것이다.

**Key Characteristics:**
- 구조적 명확함은 유지하면서도 차갑거나 딱딱하지 않은 인터페이스
- 충분한 여백과 낮은 시각적 피로도를 기반으로 한 안정적인 레이아웃
- 제품 배경은 중립적인 컬러 `--background`(grey-50)를 중심으로 구성하고, 강조가 필요한 순간에만 포인트 컬러 `--primary`(blue-500)를 제한적으로 사용
- 부드러운 라운드 `rounded-12`와 가벼운 모션을 활용해 친근하고 유연한 인상 전달
- Interop이 유일한 단일 메인 서체 패밀리로 사용하며, 본문과 디스플레이 서체를 별도로 분리하지 않음
- 강한 드롭 섀도(Drop Shadow) 대신 다층 그림자를 활용해 부드러운 입체감을 표현
- 복잡한 기능도 부담 없이 탐색할 수 있도록 단계적으로 구성된 UX 구조

---

## Tone & Voice

키키코드의 UI 텍스트는 사용자가 **기능을 이해하고 목표를 달성하는 데 돕는 것**을 최우선으로 한다. 우리는 기술적인 전문성을 유지하되, 어렵거나 권위적인 표현은 지양한다. 모든 문구는 명확하고 친근해야 하며, 사용자를 가르치거나 평가하기보다 자연스럽게 안내하는 것을 원칙으로 한다.

복잡한 기술 용어보다 사용자의 언어를 사용하고, 불필요한 수식보다 핵심 메시지를 우선한다. 또한 오류나 실패 상황에서는 차갑거나 기계적인 표현 대신, 문제를 이해하고 다음 행동을 제안하는 방식으로 소통한다.

### Clear before Clever (명료함이 우선)
재치 있는 표현보다 **명확한 이해를 돕는 표현**을 우선한다. 사용자는 문구를 해석하는 데 시간을 쓰지 않고, 바로 행동할 수 있어야 한다.
| Good | Avoid |
|---|---|
| 연결에 실패했습니다. 잠시 후 다시 시도해 주세요. | 앗, 뭔가 오류가 생겼어요. |
| 워크플로우를 삭제하시겠습니까? | 잠시만요, 이 워크플로우가 사라질 수도 있어요! |

### Professional, Yet Approachable (전문적이지만 친근하게)
전문성을 유지하면서도 부담 없이 다가갈 수 있는 톤을 지향한다. 안내와 정보 전달에는 **하십시오체**를 기본으로 사용하되, 사용자의 행동을 유도하거나 요청하는 경우에는 자연스러운 **해요체**를 사용한다.
| Good | Avoid |
|---|---|
| 업로드에 실패한 파일이 있습니다. | 업로드에 실패한 파일이 있어요. |
| 필수 입력 항목을 확인해 주세요. | 필수 입력 항목을 확인하세요. |

### Guide, Don't Command (안내하되, 명령하지 않기)
사용자에게 무엇을 해야 하는지 명령하기보다, **다음 행동을 안내**한다. 메시지는 현재 상태를 설명하는 데 그치지 않고, 사용자가 취할 수 있는 다음 단계를 함께 제시해야 한다. 
| Good | Avoid |
|---|---|
| 초대에 실패한 사용자가 있습니다. 이메일을 확인하고 다시 초대해 주세요. | 사용자를 초대할 수 없습니다. |
| 소유자 권한을 내려놓을 수 없습니다. 먼저 다른 워크스페이스 소유자를 추가해 주세요. | 워크스페이스 소유자를 추가하세요. |

---

## Color — Raw Palette

Figma Variable Collection `Color`의 명도 스케일. 단일 모드. `00`(거의 흰색) → `900`(가장 어두움).
CSS 변수는 `--{name}-{step}` 로 정의되고, Tailwind v4 `@theme inline`에서 `--color-{name}-{step}` 으로 노출된다 → 유틸 클래스 `bg-grey-100`, `text-blue-600`, `stroke-red-500` 등으로 사용.

> **실값(HEX/OKLCH)은 [tokens.md](design-system/tokens.md)** 를 참조한다. 아래 표는 토큰의 **존재 여부와 역할**만 기록한다 — AI는 유틸 클래스명만 알면 되고, 좌표를 직접 타이핑할 일이 없다.

### Grey (UI 기본 / 텍스트 / 보더 / 배경)
| Step | 역할 |
|---|---|
| `grey-00` | 카드/표면 최상단(흰색) |
| `grey-50` | 페이지 기본 배경 |
| `grey-100` | 인풋 배경 / 강조 배경(연한) |
| `grey-200` | 구분선 / 카드 보더 |
| `grey-300` | 인풋·버튼 보더 |
| `grey-400` | 비활성 텍스트·아이콘 / 강한 보더 |
| `grey-500` | 비활성(disabled) 텍스트 / 보조 라벨 |
| `grey-600` | placeholder / 사이드바 텍스트 |
| `grey-700` | 보조(secondary) 텍스트 |
| `grey-800` | 강조 텍스트(hover) |
| `grey-900` | 기본 텍스트 |
| `grey-opacity-5000` | grey-00 alpha 0.4 — 오버레이/딤드용 |

### Blue (Primary — 강조 / 포커스)
| Step | 역할 |
|---|---|
| `blue-50` ~ `blue-400` | tint 배경 / 연한 단계 |
| `blue-500` | **기본 accent** (포커스 보더, 체크 on, 스위치 on) |
| `blue-600` | **Primary 버튼 base** |
| `blue-700` | Primary hover |
| `blue-800` | Primary active |
| `blue-900` | 최심 단계 |

### Violet (Secondary / 브랜드)
| Step | 역할 |
|---|---|
| `violet-100` ~ `violet-400` | tint / 연한 단계 |
| `violet-500` | 브랜드 Secondary 기본 |
| `violet-600` ~ `violet-900` | 짙은 단계 |

### Red (Error / Danger)
| Step | 역할 |
|---|---|
| `red-50` ~ `red-400` | tint 배경 / 연한 단계 |
| `red-500` | destructive |
| `red-600` | alert / 위험 버튼 |
| `red-700` | 실패 상태 텍스트/도트 |
| `red-800` ~ `red-900` | 짙은 단계 |

### Green (Success) — 50/200/800 미정의
| Step | 역할 |
|---|---|
| `green-100` | tint 배경 |
| `green-300` ~ `green-500` | 중간 단계 |
| `green-600` | 성공 상태 텍스트/도트 |
| `green-700` / `green-900` | 짙은 단계 |

### Yellow (Warning) — 200/400/500 미정의
| Step | 역할 |
|---|---|
| `yellow-100` / `yellow-300` | tint / 연한 단계 |
| `yellow-600` | **warning** 기본 |
| `yellow-700` ~ `yellow-900` | 짙은 단계 |

### Mint (Info / Accent) — 100/300/600/900만 정의
| Step | 역할 |
|---|---|
| `mint-100` / `mint-300` / `mint-600` / `mint-900` | Info/Accent 단계 (정의된 step만) |

### Orange — 100/300/600/900만 정의
| Step | 역할 |
|---|---|
| `orange-100` / `orange-300` / `orange-600` / `orange-900` | Accent 단계 (정의된 step만) |

> ⚠️ Green/Yellow/Mint/Orange는 **일부 step만 정의**되어 있다. 코드에 없는 step(예: `mint-500`)을 임의로 가정하지 말 것.

---

## Color — Semantic Tokens

위 raw 팔레트를 **alias**한 의미 기반 토큰. 화면 구현 시 가능하면 raw 컬러보다 **시맨틱 토큰을 우선 사용**한다. (`global.css :root`)

### 표면 / 텍스트 기본
| Token | = | 용도 |
|---|---|---|
| `--primary` | `--blue-500` | 브랜드 Primary (accent 기준) |
| `--background` | `--grey-50` | 페이지 기본 배경 |
| `--foreground` | `--grey-900` | 기본 텍스트 |
| `--popover` | `--grey-50` | 팝오버 배경 |
| `--popover-foreground` | `--grey-900` | 팝오버 텍스트 |
| `--muted-foreground` | `--grey-500` | 비활성(disabled) 텍스트 |
| `--accent` | `--grey-100` | 강조 배경(연한) |
| `--hr-color` | `--grey-200` | 구분선 |
| `--ring` | `oklch(0.708 0 0)` | 포커스 링(기본 무채색) |
| `--border` | (무채색 fallback) | 전역 보더 fallback |
| `--destructive` | `--red-500` | 파괴적 동작 |
| `--alert` | `--red-600` | 경고/알림 |
| `--warning` | `--yellow-600` | 주의 |

> `--primary`는 **blue-500으로 지정**한다. `--secondary` / `--muted`는 shadcn 기본 무채색 oklch 상태다.
>
> **텍스트 색상 단계**: 기본 `--grey-900` · 보조(secondary) `--grey-700` · 비활성(disabled) `--grey-500`. 보조/비활성용 시맨틱 alias는 없으므로 grey 스케일을 직접 사용한다. (`--muted-foreground`는 grey-500 = 비활성 단계)

### Card
| Token | = |
|---|---|
| `--card` | `--grey-00` |
| `--card-selected-background` | `--grey-100` |
| `--card-accent` | `--blue-500` |
| `--card-foreground` | `--grey-900` |
| `--card-border` | `--grey-200` |

### Sidebar
| Token | = |
|---|---|
| `--sidebar` | `--grey-50` |
| `--sidebar-foreground` | `--grey-600` |
| `--sidebar-icon` | `--grey-600` |
| `--sidebar-accent` | `--grey-200` |
| `--sidebar-accent-foreground` | `--grey-900` |
| `--sidebar-accent-icon` | `--blue-500` |
| `--sidebar-border` | `--grey-200` |

### Input
| Token | = |
|---|---|
| `--input` | `--grey-100` (배경) |
| `--input-placeholder` | `--grey-600` |
| `--input-border` | `--grey-300` |
| `--input-accent` | `--blue-500` (포커스 보더) |
| `--input-alert-border` | `--red-500` |
| `--input-alert-text` | `--red-600` |

### Select
| Token | = |
|---|---|
| `--select-background` | `--grey-100` |
| `--select-border` | `--grey-300` |
| `--select-foreground` | `--grey-900` |
| `--select-placeholder` | `--grey-600` |
| `--select-chevron` | `--grey-600` |

### Button
| Token | = |
|---|---|
| `--btn-alert` | `--red-600` |
| `--btn-active` | `--blue-600` |
| `--btn-foreground` | `--grey-00` |
| `--btn-cancel` | `--grey-00` |
| `--btn-outline-border` | `--grey-300` |
| `--btn-cancel-border` | `--grey-300` |
| `--btn-cancel-foreground` | `--grey-700` |

### Checkbox List
| Token | = |
|---|---|
| `--checkboxlist-background` | `--grey-50` |
| `--checkboxlist-hover-background` | `--grey-100` |
| `--checkboxlist-border` | `--grey-200` |
| `--checkboxlist-hover-border` | `--grey-300` |
| `--checkboxlist-checked-border` | `--blue-500` |

### Modal
| Token | = | 용도 |
|---|---|---|
| `--modal-background` | `--grey-700` | 모달 딤/배경 |

---

## Typography

UI 전반 **Interop** 단일 폰트(한/영/숫자 통일). `@font-face`로 Regular(400) / SemiBold(600) / Bold(700) 3종 weight 로드. **ExtraBold(800)는 없음.**

- 폰트 스택: `--font-base: "Interop", sans-serif;` (Tailwind `font-base`). Interop 미로드 시 폴백은 Tailwind 기본(`--font-geist-sans` / `--font-geist-mono`).
- **line-height: 전 스타일 공통 `1.5` (150%)** — `--line-height`
- Tailwind 유틸: `text-title-1` … `text-caption`, weight는 `font-normal` / `font-semibold` / `font-bold`

| Token (Tailwind) | rem | px | 용도 |
|---|---|---|---|
| `text-title-1` | `2rem` | 32 | Greeting / Docs title |
| `text-title-2` | `1.5rem` | 24 | Page title |
| `text-title-3` | `1.25rem` | 20 | Drawer / Popup title |
| `text-body-1` | `1rem` | 16 | Label / button / tab |
| `text-body-2` | `0.875rem` | 14 | 기본 본문 / button |
| `text-body-3` | `0.75rem` | 12 | 컴포넌트 **내부** 소형 텍스트 (칩·버튼 small·드롭다운 그룹 라벨) |
| `text-caption` | `0.75rem` | 12 | 컴포넌트 **외부** 보조 설명 (필드 하단 도움말·메타 텍스트) |

> letter-spacing 토큰은 코드에 정의되어 있지 않다.

---

## Icon System

Lucide 아이콘 기반. **색상은 `stroke-*`로 제어** — 텍스트 색을 따라가며 hover/active 시 함께 전환된다.

| 크기 | 클래스 | 주요 맥락 |
|---|---|---|
| 8px | `w-2 h-2` | 상태 도트, 버튼 small trailing 아이콘 |
| 12px | `w-3 h-3` | 버튼 leading 아이콘(기본), 체크 아이콘 |
| 14px | `size-3.5` | Select 선택 체크 아이콘 |
| 16px | `w-4 h-4` | **기본 UI 아이콘**, Select chevron, 드롭다운 메뉴 아이콘, 버튼 large trailing |
| 20px | `w-5 h-5` | 사이드바 nav 아이콘 |
| 24px | `w-6 h-6` | 헤더·주요 액션 아이콘 |

`stroke-width`: 기본 `1.5`, active 상태 `2` (Sidebar nav item 선택 시 굵어짐으로 강조).

---

## Spacing

4px 베이스 그리드. Figma `Number` 컬렉션 `GAP` 스코프. 단위 px.

```
0, 2, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 48, 60
```

### 사용 의미 (권장)
스케일 안에서 **언제 어느 값을 쓰는지**의 기준. 강제는 아니지만 화면 간 간격 일관성을 위해 따른다.

| 맥락 | 권장 값 | 비고 |
|---|---|---|
| Inline gap (아이콘↔텍스트, 칩 내부) | 4 ~ 8 | 버튼 아이콘 gap은 8 고정(아래 Buttons) |
| 컴포넌트 내부 패딩 (버튼·인풋·칩) | 8 ~ 16 | 인풋 `px-4 py-2`(16/8) |
| 폼 필드 간 세로 간격 | 16 | label↔input은 4~8 |
| 카드 / 패널 내부 패딩 | 16 ~ 24 | |
| 섹션(그룹) 간 간격 | 24 ~ 48 | |
| 페이지 컨테이너 좌우/상하 패딩 | 32 ~ 48 | [Layout](#layout--composition) 참조 |

> Tailwind 기본 spacing 스케일과 함께 사용. 위 값들이 디자인상 허용된 gap/padding 단계다.

---

## Layout & Composition

페이지·오버레이의 골격 치수 기준. **코드에는 레이아웃 전용 토큰이 없고 컴포넌트별 하드코딩값만 존재**하므로, 아래는 관찰값을 근거로 한 **권장 기본값**이다. **강제 규칙이 아니며 프로젝트별로 조정 가능**하다.

### 원칙
- 기본 셸은 **좌측 사이드바 + 본문 2단** 구성.
- 본문은 **max-width 컨테이너**로 가운데 정렬, 좌우 균등 패딩.
- 오버레이(모달/드로어/팝오버)는 [Z-Index](#z-index) 스케일을 따르고, 폭은 콘텐츠 밀도에 맞춰 아래 기본값에서 선택.

### 권장 기본값
| 항목 | 권장 기본값 | 비고 |
|---|---|---|
| 페이지 콘텐츠 max-width | `1120px` | 넓은 대시보드는 확장 가능 |
| 페이지 패딩 (좌우 / 상하) | `40px` / `32px` | 좁은 뷰포트는 축소 |
| 사이드바 폭 | `240px` (compact `184px`) | |
| 드로어 / 패널 폭 | `360 ~ 400px` (기본 `368px`) | 설정·상세 패널 |
| 모달 폭 | small `400` / 기본 `480` / large `640` | 기본 480 |
| 섹션 세로 리듬 | 그룹 간 `48px`, 그룹 제목 하단 `16px` | |

> 위 수치는 [Spacing](#spacing) 스케일과 정합한다(40·48·24·16 등). 신규 화면은 가능하면 이 기본값에서 출발한다.

---

## Radius

**4px 그리드 정렬 숫자 스케일** — Figma `Number/CORNER_RADIUS`(0·2·4·8·12·16·20·24)와 1:1. 모든 컴포넌트에서 이 스케일을 기준으로 사용한다.

| Token (Tailwind) | px | 실사용 |
|---|---|---|
| `rounded-2` (`--radius-2`) | 2 | |
| `rounded-4` (`--radius-4`) | 4 | 버튼 small |
| `rounded-8` (`--radius-8`) | 8 | 버튼 medium (h-32) |
| `rounded-12` (`--radius-12`) | 12 | 버튼 large · 인풋(h-40) · 카드 |
| `rounded-16` (`--radius-16`) | 16 | |
| `rounded-full` | — | Pill(완전 둥근), 칩 |


---

## Shadow

`--shadow-sm/md/lg` 같은 토큰은 **없다.** 표면 종류에 따라 두 패턴을 사용한다.

| 용도 | 스펙 |
|---|---|
| 카드 / 플로팅 패널 등 **떠 있는 표면** | 다층 그림자 (5-layer drop shadow, grey-900 base) |
| 팝오버 / 드롭다운 **표면** | `rounded-12` · grey-50 배경 · grey-300 보더 · grey-400 shadow · backdrop-blur `6px` |

---

## Z-Index

레이어 충돌 방지용 z-index 스케일. (`global.css :root`) 신규 오버레이는 **반드시 이 값을 따른다.**

| Token | Value | 레이어 |
|---|---|---|
| `--panel-z-index` | `999` | 패널 |
| `--floating-page-z-index` | `10000` | 플로팅 페이지 |
| `--popover-z-index` | `10001` | 팝오버 |
| `--floating-page-content-z-index` | `10001` | 플로팅 페이지 콘텐츠 |
| `--modal-z-index` | `100002` | 모달 |
| `--modal-content-z-index` | `100003` | 모달 콘텐츠 |
| `--tooltip-z-index` | `100004` | 툴팁 (최상위) |

---

## Interaction

키키코드의 인터랙션은 사용자가 기능과 구조를 자연스럽게 이해하고 익힐 수 있도록 돕는 안내자 역할을 수행한다. 모든 움직임과 반응은 목적이 명확해야 하며, 불필요한 시각적 과부하를 주지 않도록 가볍고(Light) 민첩하게(Agile) 설계한다.

**Motion Principle (움직임 원칙)**
움직임은 시각적 장식이 아닌, 사용자의 이해와 몰입을 돕는 기능적 요소로 활용한다.
- 가볍고 민첩한 움직임: 불필요한 긴 애니메이션은 피하고, **0.2초 이내**의 짧은 지속 시간을 통해 시스템의 반응 속도가 빠르다는 인상을 제공한다.
- 목적 지향적인 모션: 화면 요소의 위계(Hierarchy)를 설명하거나, 사용자의 초점을 중요한 정보로 유도할 때에만 모션을 사용한다. 예를 들어, 새로운 창이 열릴 때는 부드럽게 나타나 화면의 연속성을 유지한다.
- 부드러운 유연함: 딱딱한 직선 이동 대신, **부드러운 커브**나 **이징(Easing)**을 활용하여 전반적인 디자인 컨셉인 유연하고 친근한 인상을 보조한다.

**Feedback & Response (피드백 및 응답)**
사용자가 시스템을 제어하고 있다는 느낌을 유지할 수 있도록, 모든 행동에 대해 즉각적이고 명확하게 반응한다.
- 즉각적인 상태 변화: 클릭, 호버(Hover) 등 사용자 입력에는 지연 없이 시각적인 변화를 제공한다. 마우스 오버(Hover) 시에는 다층 그림자나 미묘한 배경 컬러 변화를 사용하여, 차분하면서도 명확한 피드백을 전달한다.
- 차분한 확인: 중요한 정보나 상태 변경(성공/오류) 시, 강렬한 알림 대신 **스낵바(Snackbar)**와 같은 가벼운 마이크로 인터랙션을 통해 최소한의 방해로 결과를 전달한다. 변경 사항이 저장되지 않은 상태에서 화면을 이탈할 경우, 저장되지 않은 내용이 손실될 수 있음을 **모달(ConfirmModal)**을 통해 확인한다.
- 구조 인지: 탑 바(Top Bar)의 뒤로 가기 버튼 등을 유지하여 사용자가 현재 더 깊은 단계로 진입했음을 인지하도록 돕는다.

**Structural Guidance (구조적 안내)**
복잡한 기능도 부담 없이 탐색할 수 있도록, 인터랙션은 정보의 논리적 구조를 강화해야 한다.
- 단계적 정보 노출: 복잡한 워크플로우는 한 번에 모든 정보를 보여주기보다, 사용자의 행동에 따라 정보를 **단계적으로 노출**하는 방식(예: 스텝퍼, 프로그레시브 디스클로저)을 사용한다.
- 직관적인 계층 구조: 깊이(Depth)감이 필요한 경우, 강한 Drop Shadow 대신 다층 그림자를 사용하여 요소 간의 위계를 부드럽게 표현하고 안정적인 생산성 툴의 느낌을 유지한다.
- 여백의 활용: 충분한 여백은 인터랙션 요소 간의 구분을 명확히 하여, 사용자가 원하는 기능을 직관적으로 선택할 수 있도록 돕는다.

---

## Buttons

**명명된 Variant + Size enum** 구조.

### 컴포넌트
| 컴포넌트 | 비고 |
|---|---|
| `IconTextButton` | 아이콘+텍스트 (기본) |
| `IconButton` | 아이콘 전용 정사각 |
| `IconTextToggleButton` | 토글형 |

### Size (`IconTextButton`)
| size | 높이 | radius | padding | **gap** | 텍스트 | trailing 아이콘 |
|---|---|---|---|---|---|---|
| `small` | `h-6` (24px) | `rounded-4` | `px-2` | `gap-2` (8px) | `text-body-3` (12) | `w-2 h-2` (8) |
| `medium` (기본) | `h-8` (32px) | `rounded-8` | `px-3` | `gap-2` (8px) | `text-body-2` (14) | `w-3 h-3` (12) |
| `large` | `h-10` (40px) | `rounded-12` | `px-4` | `gap-2` (8px) | `text-body-2` (14) | `w-3 h-3` (12) |
| `expanded` | `w-full h-10` | `rounded-12` | `px-4` | `gap-2` (8px) | `text-body-3` (12) | `w-3 h-3` (12) |

> gap(아이콘↔텍스트 간격)은 **모든 사이즈 8px(`gap-2`) 고정** — Figma 1-1506 `Spacing/8`과 일치.

### 아이콘 동작 (Icon)
`IconTextButton`은 아이콘 슬롯이 **2개**다 (`iconTextButton.tsx`).

| slot | 위치 | 크기 | 비고 |
|---|---|---|---|
| `innerBlockIconComponent` | **leading**(텍스트 왼쪽) | 고정 `w-3 h-3` (12px) | 텍스트와 같은 내부 블록(`flex gap-2`)에 들어감 |
| `iconComponent` | **trailing**(버튼 오른쪽 끝) | size별 (위 표: small 8 / 그 외 12) | 버튼 최상위 flex의 우측 |

- 레이아웃: `[버튼 flex, gap-2] → [내부블록 flex gap-2 → leading 아이콘(12) + 텍스트] + [trailing 아이콘]`. 두 간격 모두 `gap-2`(8px).
- 아이콘 하나만 쓸 때: 왼쪽 아이콘은 `innerBlockIconComponent`, 오른쪽 아이콘은 `iconComponent`로 전달.
- 아이콘 색상은 `stroke-*`로 제어되어 **텍스트 색을 따라가며** hover/active 시 함께 전환된다(`sharedIconActiveStyles` / `sharedIconDisableStyles`).
- 아이콘 전용(텍스트 없음)은 `IconButton`(아래 정사각 표)을 사용한다.

### Size (`IconButton`, 정사각)
| size | 크기 | radius | 아이콘 |
|---|---|---|---|
| `small` | `w-6 h-6` (24px) | `rounded-8` | `w-3 h-3` (12) |
| `medium` | `w-8 h-8` (32px) | `rounded-8` | `w-3 h-3` (12) |
| `large` | `w-10 h-10` (40px) | `rounded-12` | `w-4 h-4` (16) |

### Style Variant — Default / Hover / Active / Disabled

| Variant | 크기 | Default | Hover | Active | Disabled |
|---|---|---|---|---|---|
| **Secondary Solid (sm)** | h-32 · rounded-8 | `bg-grey-00` border `grey-300`, text `grey-700` | `bg-grey-200` border `grey-400`, text `grey-800` | `bg-grey-300` border `grey-400`, text `grey-900` | `bg-grey-00` border `grey-200`, text `grey-500` |
| **Secondary Solid** | h-40 · rounded-12 | `bg-grey-100` border `grey-300`, text `grey-700` | `bg-grey-200` border `grey-400` | `bg-grey-300` border `grey-400`, text `grey-800` | border `grey-200`, text `grey-500` |
| **Primary Solid** | h-40 · rounded-12 | `bg-blue-600` text `grey-00` | `bg-blue-700` | `bg-blue-800` | `bg-blue-300` text `grey-00` |
| **Primary Outline** | h-40 · rounded-12 | `bg-grey-00` border `grey-400`, text `blue-600` | `bg-grey-100` border `blue-700` | `bg-grey-200` | border `blue-100`, text `blue-300` |
| **Secondary Outline** | h-40 · rounded-12 | `bg-transparent` border `grey-300`, text `grey-700` | `bg-grey-100` | `bg-grey-200`, text `grey-800` | border `grey-200`, text `grey-500` |
| **Danger Outline** | h-40 · rounded-12 | `bg-transparent` border `red-200`, text `red-500` | `bg-red-100` border `red-400`, text `red-700` | `bg-red-200` border `red-400`, text `red-800` | border `red-100`, text `red-200` |
| **Danger Ghost** | h-24 · rounded-4 | `bg-transparent` | `bg-red-100` text `red-500` | `bg-red-200` text `red-800` | text `grey-400` |
| **Ghost** | h-40 · rounded-12 | `bg-transparent` | `bg-grey-100` | `bg-grey-200` | text `grey-400` |
| **Icon Ghost** | 32×32 · rounded-8 | `bg-transparent` | `bg-grey-100` | `bg-grey-200` | — |
| **Icon Primary** | 40×40 · rounded-12 | `bg-blue-600` | — | `bg-blue-700` | `bg-blue-300` text `blue-50` |

- 아이콘 색상은 `stroke-*`로 별도 제어되며 hover/active 시 텍스트와 함께 전환된다.
- Disabled는 `cursor-not-allowed pointer-events-none`.

---

## Inputs

구현: shadcn `ui/input.tsx` 기반 + 조합 입력(`NumberInput`, `ResizableInput`, `ConditionInput`).

사이즈: **40px(기본)** · 32px. (디자인엔 48/24px도 존재 — Figma 16-1241)

| Property | Value |
|---|---|
| 높이 | **40px**. 코드 표기는 `h-[calc(40px+2px)]` — `box-sizing: border-box`에서 1px 상·하 보더를 더해 **콘텐츠 영역을 40px로 맞추는** 보정값(총 박스 42px)이다. **디자인 높이는 40px로 본다.** |
| 배경 | `bg-input` (= `--grey-100`) |
| 보더 | `border-input-border` (= `--grey-300`) |
| Radius | `rounded-12` (12px) — shadcn/ui 프로젝트에서는 `rounded-lg` 동일값 |
| Padding | `px-4 py-2` |
| 폰트 | `text-body-2` (14px) |
| placeholder | `--input-placeholder` = `--grey-600` |
| Focus | `focus-visible:border-input-accent` (= `--blue-500`) |
| Error | `aria-invalid` → `border-destructive`, text/placeholder `destructive`(= `--red-500`), ring `destructive/20` |
| Disabled | `bg-grey-100` border `grey-200` text `grey-400` placeholder `grey-400`, `cursor-not-allowed` |
| shadow | `shadow-xs` |

- 네이티브 input 리셋이 필요할 때 `.input-reset` 클래스 사용.
- Textarea류는 `TextAreaLight`.
- 인라인 에러 메시지는 `ErrorCaption`.

### Select

shadcn `ui/select.tsx` 기반. 시맨틱 토큰: `--select-*`.

**Trigger (닫힌 상태)**

| Property | Value |
|---|---|
| 높이 | 40px 기본 / `size="sm"` 32px |
| 배경 / 보더 | `bg-select-background` (grey-100) / `border-select-border` (grey-300) |
| Radius | `rounded-12` (12px) 기본 / `rounded-8` (8px) `size="sm"` |
| Padding | `px-4 py-2.5` |
| 폰트 | `text-body-2` (14px), placeholder `text-select-placeholder` (grey-600) |
| Chevron | 16px(`size-4`), `text-select-chevron` (grey-600), trailing |

**Content (드롭다운 열린 상태)**

| Property | Value |
|---|---|
| 배경 | `bg-grey-00/40` (40% 불투명 white) |
| 보더 / Radius | `border-grey-200` / `rounded-8` |
| backdrop-blur | `6px` (팝오버 공통) |
| 아이템 padding | `py-1.5 pr-8 pl-2` (예약 공간: 우측 32px = 선택 체크 영역) |
| 아이템 radius | `rounded-4` |
| 아이템 hover | `bg-accent` (grey-100) |
| 선택된 아이템 | 우측 14px 체크 아이콘 |

---

## Chips & Status

pill(`rounded-full`) 기본 · `body-3`(12).

### TextChip (`textChip.tsx`)
기본 텍스트 칩.
| Property | Value |
|---|---|
| 형태 | `rounded-full` (pill), `border` |
| Padding | `py-0.5 px-2` |
| 배경 | `bg-grey-50` |
| 보더 | `border-grey-300` |
| 텍스트 | `text-body-3` (12px) `text-grey-900` `font-normal` |

### StateTextChip (`stateTextChip.tsx`)
상태 도트(`w-2 h-2 rounded-2`) + 텍스트. `status` 4종.

| status | Dot 배경 | 텍스트 색 |
|---|---|---|
| `active` | `bg-green-600` | `text-green-600` |
| `inactive` | `bg-grey-600` | `text-grey-600` |
| `working` | `bg-blue-600` | `text-blue-600` |
| `failure` | `bg-red-700` | `text-red-700` |

레이아웃: `px-2 py-0.5 flex gap-2 items-center`, 텍스트 `text-body-3`.

### Status Chip (pill, 아이콘) — Figma 28-1122
상태를 색 배경 pill로 표시. **Light**(tint 배경 + 텍스트색) / **Solid**(채움 + 흰 텍스트) 두 톤.

| 상태 | Light 배경 / 텍스트 | Solid 배경 |
|---|---|---|
| Running | `bg-blue-500/12` / `text-blue-700` | `bg-blue-500` |
| Error | `bg-red-100` / `text-red-600` | `bg-red-500` |
| Success | `bg-green-100` / `text-green-600` | `bg-green-500` |
| 추천(Recommend) | `bg-violet-500/18` / `text-violet-700` | `bg-violet-500` |

- pill(`rounded-full`), `body-3`, 선택적 leading 아이콘(12px).

### Badge
- **번호 배지**: `blue-500` 배경 + 흰 텍스트, `rounded-4`, 최소 20px (예: `01`).
- **추천 배지**: `violet` light(`bg-violet-500/18` / `text-violet-700`), pill.


---

## Form Controls

모두 구현체 존재. 신규 제작 금지, 재사용.

| 컨트롤 | 컴포넌트 | 비고 |
|---|---|---|
| 체크박스 | `CustomCheckbox` | unchecked / checked / indeterminate / error / disabled |
| 라디오 | `CustomRadioGroup` | |
| 스위치 | `CustomSwitch` | off → grey-300 / on → blue-500 |
| 논리연산 스위치 | `LogicalOperatorSwitch` | AND · OR 토글 |
| 세그먼트/탭 필터 | `SegmentButton` | |
| 슬라이더 | `CustomSlider` / `SliderWithNumber` | 숫자 입력 병행 |

- active 강조색은 `--blue-500`.
- 체크박스 리스트 행: `CheckboxListItem`, 색상은 `--checkboxlist-*` 토큰.

### Checkbox 스펙 (Figma 45-2719)
- 크기 **20×20px**, radius **4px**(`rounded-4`).
- Unchecked: 배경 `grey-50`, 보더 `1.5px grey-400`.
- Checked: 배경 `blue-500`, 흰색(`grey-00`) 체크.
- **Indeterminate(Not all)**: 배경 `blue-500` + 흰색 minus(가로 막대).
- **Error**: 보더 `red-500`.
- Disabled: unchecked 배경 `grey-100`; disabled-checked 배경 `blue-200`.
- 상태 매트릭스: Selected(on/off) × Hover × Not all × Error × Dark Mode.

---

## Navigation

### Sidebar Nav Item

| 상태 | 배경 | 텍스트 | 아이콘 |
|---|---|---|---|
| Inactive (기본) | `transparent` | `--sidebar-foreground` (grey-600) | `--sidebar-icon` (grey-600), strokeWidth `1.5` |
| Hover | `bg-sidebar-accent/50` (grey-200 50%) | 변화 없음 | 변화 없음 |
| Active | `bg-sidebar-accent` (grey-200) | `--sidebar-accent-foreground` (grey-900) | `--sidebar-accent-icon` (blue-500), strokeWidth `2` |

- 레이아웃: `flex gap-3 items-center`, padding `px-3 py-2`, `rounded-8`.
- 상태 전환: `transition-colors duration-200`.
- Active 상태는 hover가 없다 (조건부 — active 시 hover 스타일 비활성).

---

## Overlays

### Modal — store + Renderer 패턴
직접 mount 금지. **store 패턴**으로 모달을 열고, 컴포넌트 내부 close hook으로 닫는다. store·hook·import 경로는 프로젝트별 구현을 따른다.

**공통 모달 종류**

| 종류 | 비고 |
|---|---|
| 확인(Confirm) | title + description + primary/secondary 버튼 + 폭 옵션 |
| 경고/삭제 확인 | destructive 동작 재확인 |
| 설정 본문 | 설정 레이아웃 전용 |

- 모달 배경: `--modal-background` (= `--grey-700`).
- 모달 폭: 기본 `480px` (`data.modalWidth`로 조정). 권장 단계는 [Layout](#layout--composition) 참조.
- z-index: 모달 `100002`, 콘텐츠 `100003`.

### Dropdown / Popover
드롭다운은 **단순 메뉴가 아니라** 용도별로 여러 종이며 **검색 커맨드 팝업** 패턴을 공유한다 (Figma 1488-146344).

컴포넌트: 용도별 드롭다운(다수 변형), 툴팁(`CustomTooltipRoot` / `MouseTrackingTooltipRoot` / `QuestionMarkTooltip`).

**패턴 4종**
- **Context Menu** — 아이템 + trailing 단축키/아이콘, divider, danger(`red-600`) 아이템.
- **Search Command** — 상단 검색 입력 + 그룹 라벨(`body-3 SemiBold`) + 결과 리스트.
- **Multi-select** — 좌측 체크박스(18px) + 라벨, 하단 footer 액션.
- 공통 아이템: padding `8px 12px`, radius `8`(rounded-8), `body-2`. active = `blue` 계열 배경, danger = `red-600`.

**표면(surface)**
- 코드 유틸 `.popover-content-custom`: 보더 `grey-300`, 배경 `grey-50`, radius `12`, shadow `0 4px 12px grey-400`.
- 팝오버/드롭다운 표면 **backdrop-blur는 `6px`** 고정.
- z-index: 팝오버 `10001`, 툴팁 `100004`(최상위).

### Tooltip

2가지 밀도 variant.

| Property | Thin | Thick |
|---|---|---|
| Padding | `px-3 py-1` | `px-4 py-2` |
| Radius | `rounded-4` (4px) | `rounded-8` (8px) |
| 배경 / 보더 | `bg-grey-00` / `border-grey-200` | 동일 |
| 텍스트 | `text-body-3 text-grey-900` | 동일 |

- 등장 딜레이: `300ms`. 트리거에서 `4px` 오프셋.
- z-index: `--tooltip-z-index` (`100004`, 최상위 — 모달 위).

### Floating Page
전체 화면 오버레이(모달 스택과 별개). store 패턴으로 열고 닫으며 z-index `10000`. 예: 워크스페이스·설정 페이지.

---

## System States
시스템 상태는 콘텐츠와 작업의 진행 상황을 사용자에게 전달하는 핵심 피드백 요소이다. 각 상태를 일관되게 사용하여 명확하고 예측 가능한 사용자 경험을 제공한다.

- **Empty States** — 사용자가 다음 행동을 수행할하도록 콘텐츠 생성 또는 추가를 위한 안내와 액션을 함께 제공한다.
- **Skeleton** — 콘텐츠가 로드되기 전 구조를 미리 보여주는 상태이다. 사용자가 화면 구성을 예측하고 로딩 대기 시간을 보다 짧게 인지하도록 돕는다.
- **Disabled** — 사용자가 해당 요소와 상호 작용할 수 없는 상태이다. 요소가 비활성화된 이유와 다시 활성화할 수 있는 방법을 명확히 안내한다.
- **Loading** — 데이터 조회 또는 작업이 진행 중인 경우 Progress Indicator를 제공하며, 가능하다면 진행률을 함께 표시한다.
- **Error** — 오류 원인을 이해할 수 있는 설명과 함께 적절한 대응 방안을 제공한다.
- **Success** — 작업이 정상적으로 완료되었다는 텍스트와 시각적 피드백을 통해 결과를 명확하게 전달한다. 
- **Streaming** — 콘텐츠가 실시간으로 생성되거나 전달되는 상태이다. 현재 진행 중임을 명확히 보여주고, 사용자가 응답을 기다리는 동안 진행 상황을 인지하도록 돕는다.
- **Cancelled** — 사용자 또는 시스템에 의해 진행 중이던 작업이 중단된 상태이다. **작업이 안전하게 종료되었음을 확인시키고** 필요한 경우 이전 상태로 복원할 수 있는 옵션을 제공합니다.

### System 컴포넌트
시스템 상태에 대한 시각적 피드백 시 사용되는 컴포넌트의 디자인 토큰이다.

| 상태 (State) | 컴포넌트 종류 | Border | Background | Radius | Shadow |
|---|---|---|---|---|---|
| **Error** | Snackbar | `red-300` | `grey-00` | `12` | `0 4px 12px grey-400` |
| **Success** | Snackbar | `green-300` | `grey-00` | `12` | `0 4px 12px grey-400` |

---

## Dark Mode

⚠️ **현재 다크모드는 미완성 상태다.** `.dark` 클래스(`@custom-variant dark`)는 정의돼 있으나, 값이 대부분 **shadcn 기본 무채색 oklch**이고 브랜드 팔레트(Blue/Violet/Grey 스케일)가 **alias되어 있지 않다.**

```
.dark { --background: oklch(0.145 0 0); --foreground: oklch(0.985 0 0);
        --card: oklch(0.205 0 0); --border: oklch(1 0 0 / 10%);
        --input: oklch(1 0 0 / 15%); ... }
```

- 따라서 다크모드 화면을 구현/제안할 때 **임의의 다크 토큰값을 지어내지 말 것.** 브랜드 다크 팔레트가 필요하면 별도 정의가 선행되어야 한다(현재 미정).
- `.dark`에는 차트색(`--chart-1`~`--chart-5`)·`--sidebar-primary`·`--sidebar-ring` 등 shadcn 기본 토큰도 포함되나 모두 브랜드 미적용 상태다.

---

## Component Inventory

이 DS를 사용하는 각 프로젝트는 아래 문서를 함께 관리한다.

- **[design-system/code-components.md](design-system/code-components.md)** — 조합 컴포넌트 목록, 드로어/설정 골격, 상태 관리 위치. 새 화면 구현 전 먼저 확인해 기존 컴포넌트를 재사용한다.
- **[design-system/tokens.md](design-system/tokens.md)** — Figma Variables export(HEX/OKLCH 원본). 본 문서가 참조하는 색상 실값.

원칙: 새 화면/컴포넌트 구현 전 **반드시 code-components.md를 먼저 확인**하고 기존 컴포넌트를 재사용한다. 없을 때만 신규 제안.

---

## Do's and Don'ts
이 섹션은 앞에서 정의된 원칙들을 실무에 적용할 때 지켜야 할 구체적인 실천 지침과 피해야 할 관행을 정리한다.

### 시각적 스타일링 및 타이포그래피 (Visual Styling & Typography)
| Category | Do (실천 사항) | Don't (지양 사항) |
|---|---|---|
| **Primary 컬러** | `primary` (`blue-500`) 컬러는 주요 카드, Input / Select 등 액센트에만 사용한다. 장식적인 용도로는 사용하지 않는다. | `blue-500` 외에 임의의 Primary 컬러를 추가하지 않는다. |
| **배경 및 대비** | 페이지의 기본 배경은 중립적인 컬러 `bg-grey-50`를 유지하고, 카드와 입력 필드에는 `bg-grey-00`, `bg-grey-100`를 사용해 부드러운 대비감을 만든다. | CTA나 구조적인 배경 영역에 Red, Green, Yellow, Mint, Orange 컬러 팔레트를 사용하지 않는다. 해당 컬러는 장식용으로만 사용한다. |
| **데코레이션** | Red, Green, Yellow, Mint, Orange 컬러 팔레트는 일러스트, 아이콘 등과 같은 장식 요소에만 사용한다. | 강한 드롭 섀도우를 사용하지 않는다. 입체감은 여러 겹의 투명한 레이어로 표현한다. |
| **라운드 (Radius)** | CTA 버튼에는 `rounded-12` 라운드를 사용하고, 버튼 크기에 따라 더 타이트한 `rounded-8`, `rounded-4` 라운드를 사용한다. | CTA 버튼이나 입력 필드에 `rounded-full`를 적용하지 않는다. 인풋 필드는 `rounded-12` (h-40) · `rounded-8` (h-32)의 라운드를 유지한다. |
| **버튼** | `blue-600` 컬러를 CTA 버튼의 베이스로 사용하고, 위험 및 삭제 상황의 버튼에는 `red-600` 컬러를 사용한다. | 버튼 텍스트의 Font Weight를 700 이상으로 올리지 않는다. 버튼에서 사용하는 기본 Weight는 400이다. |
| **타이포그래피** | 모든 타이포그래피 역할에 브랜드 전용 서체인 Interop 패밀리를 일관되게 사용한다. | 본문 텍스트에 무거운 Font Weight를 사용하지 않는다. 가독성을 위해 기본 Weight는 400을 유지하고, 700은 타이틀에만 사용한다. | 

### UX 라이팅 및 톤 (Tone & Voice)
| Category | Do (실천 사항) | Don't (지양 사항) |
|---|---|---|
| **명확성** | 복잡한 기술 용어보다 사용자가 이해하기 쉬운 일상 언어를 사용한다. | 불필요하게 재치 있거나 추상적인 은유를 사용하지 않는다. |
| **태도** | 오류 상황에서도 사용자를 탓하지 않고, 문제를 이해하고 해결책을 제시하는 친절하고 전문적인 톤을 유지한다. | 차갑거나 기계적인 표현을 사용하거나, 사용자의 수준을 평가하는 듯한 문구를 피한다. |
| **필수 항목** | 필수 입력 항목의 경우, 모든 하위 항목에 필수 표시(*)를 반복하기보다 상위 라벨에만 표시하여 시각적 과부하를 줄인다. | 필수 정보를 명확하게 구분하지 않아 사용자가 입력해야 할 항목을 인지하는 데 어려움을 주지 않는다. |

### 인터랙션 및 피드백 (Interaction & Feedback)
| Category | Do (실천 사항) | Don't (지양 사항) |
|---|---|---|
| **행동 안내** | 사용자의 행동 후에는 시스템의 현재 상태와 다음 행동(Next Step)을 명확히 안내한다. | 완료 메시지나 상태 변화 없이 단순하게 행동을 종료시키지 않는다. |
| **데이터 손실 방지** | 변경 사항이 저장되지 않은 상태에서 뒤로 가기, 닫기 등 화면을 이탈하는 행동 시 저장되지 않은 내용이 손실될 수 있음을 모달 창을 통해 경고한다. | 사용자에게 데이터 손실 위험을 고지하지 않아 중요한 작업 내용이 사라지게 하지 않는다. |
| **구조 인지** | 화면 깊이가 있는 경우, 탑 바(Top Bar)의 뒤로 가기 버튼 등을 유지하여 사용자가 '한 뎁스 들어왔다'는 구조를 인지하도록 돕는다. | 뒤로 가기 등의 필수적인 구조 인지 요소를 일관성 확보 없이 임의로 제거하지 않는다. |

### 시스템 상태 (System States)
| Category | Do (실천 사항) | Don't (지양 사항) |
|---|---|---|
| **명확한 액션** | 버튼명은 사용자의 행동 의도와 시스템의 결과를 명확하게 반영하도록 구체적으로 작성한다 (예: '변경사항 실행 취소') | '취소'와 같이 모호한 버튼명을 사용하여 설정이 초기화되는지, 이전 단계로 돌아가는지 등 결과를 혼동하게 하지 않는다. |
| **검색 결과** | 검색 결과가 없는 경우, 'Empty States' 원칙에 따라 검색 결과가 없음을 알리는 동시에 새로운 검색을 유도하는 가이드를 제공한다. | 데이터 부족 시 빈 화면만 보여주거나, 사용자의 현재 상황에 맞는 안내를 생략하여 막다른 길에 다다르게 하지 않는다. |


