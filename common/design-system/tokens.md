# Design Tokens — 색상 실값 (프로젝트별 컬러톤)

> **이 파일 = 프로젝트의 "컬러톤"이다.** [DESIGN.md](../DESIGN.md)는 토큰 **이름·역할·컴포넌트(구조)**만 정의하고,
> **실제 색값은 여기서** 정한다. 화면은 CSS 변수(`var(--primary)` 등)만 쓰므로 **이 파일만 바꾸면 전체가 그 톤으로 자동 반영**된다.
>
> **컬러톤 결정 우선순위** (`/setup-ui` 가 처리):
> 1. 회사/프로젝트 디자인 시스템 export 가 있으면 → 그 값으로 이 파일을 채운다.
> 2. 시드 컬러가 주어지면 (`/setup-ui "#7C3AED"`) → 그 색 기준으로 자동 생성한다.
> 3. 둘 다 없으면 → **아래 검정(무채색) 기본값**을 쓴다. ← *현재 커밋된 기본값*
>
> 형식: OKLCH. Light 단일 모드. `src/index.css` 에 그대로 복사 가능.

---

## 1. Raw Palette → `@theme`

> **기본값 = 검정(무채색).** Primary/Secondary 계열은 채도 0(무채색 다크)으로, brand 톤이 없을 때의 폴백이다.
> red/green/yellow/mint/orange 는 **상태 표현용 기능 색**이라 무채색으로 죽이지 않고 유지한다.

```css
@theme {
  /* ── Grey (UI 기본 / 텍스트 / 보더 / 배경) — 무채색 ── */
  --color-grey-00:  oklch(1 0 0);
  --color-grey-50:  oklch(0.985 0 0);
  --color-grey-100: oklch(0.967 0 0);
  --color-grey-200: oklch(0.922 0 0);
  --color-grey-300: oklch(0.870 0 0);
  --color-grey-400: oklch(0.708 0 0);
  --color-grey-500: oklch(0.556 0 0);
  --color-grey-600: oklch(0.439 0 0);
  --color-grey-700: oklch(0.371 0 0);
  --color-grey-800: oklch(0.269 0 0);
  --color-grey-900: oklch(0.205 0 0);
  --color-grey-opacity-5000: oklch(1 0 0 / 0.4);

  /* ── Primary 계열 (blue-* 슬롯) — 기본은 검정(무채색). 시드 컬러 주면 그 톤으로 대체 ── */
  --color-blue-50:  oklch(0.967 0 0);
  --color-blue-100: oklch(0.922 0 0);
  --color-blue-200: oklch(0.870 0 0);
  --color-blue-300: oklch(0.708 0 0);
  --color-blue-400: oklch(0.439 0 0);
  --color-blue-500: oklch(0.270 0 0);  /* 기본 accent (포커스/체크 on) */
  --color-blue-600: oklch(0.220 0 0);  /* Primary 버튼 base */
  --color-blue-700: oklch(0.180 0 0);  /* Primary hover */
  --color-blue-800: oklch(0.140 0 0);  /* Primary active */
  --color-blue-900: oklch(0.110 0 0);

  /* ── Secondary 계열 (violet-* 슬롯) — 기본은 무채색 ── */
  --color-violet-100: oklch(0.922 0 0);
  --color-violet-200: oklch(0.870 0 0);
  --color-violet-300: oklch(0.708 0 0);
  --color-violet-400: oklch(0.556 0 0);
  --color-violet-500: oklch(0.371 0 0);  /* 브랜드 Secondary 기본 */
  --color-violet-600: oklch(0.300 0 0);
  --color-violet-700: oklch(0.240 0 0);
  --color-violet-800: oklch(0.190 0 0);
  --color-violet-900: oklch(0.150 0 0);

  /* ── Red (Error / Danger) — 기능 색 유지 ── */
  --color-red-50:  oklch(0.971 0.013 17.4);
  --color-red-100: oklch(0.936 0.032 17.7);
  --color-red-200: oklch(0.885 0.062 18.3);
  --color-red-300: oklch(0.808 0.114 19.6);
  --color-red-400: oklch(0.704 0.191 22.2);
  --color-red-500: oklch(0.637 0.237 25.3);  /* destructive */
  --color-red-600: oklch(0.577 0.245 27.3);  /* alert / 위험 버튼 */
  --color-red-700: oklch(0.505 0.213 27.5);
  --color-red-800: oklch(0.444 0.177 26.9);
  --color-red-900: oklch(0.396 0.141 25.7);

  /* ── Green (Success) — 50/200/800 미정의 ── */
  --color-green-100: oklch(0.962 0.044 156.7);
  --color-green-300: oklch(0.871 0.150 154.4);
  --color-green-400: oklch(0.792 0.209 151.7);
  --color-green-500: oklch(0.723 0.219 149.6);
  --color-green-600: oklch(0.627 0.194 149.2);
  --color-green-700: oklch(0.527 0.154 150.1);
  --color-green-900: oklch(0.393 0.095 152.5);

  /* ── Yellow (Warning) — 200/400/500 미정의 ── */
  --color-yellow-100: oklch(0.973 0.071 103.2);
  --color-yellow-300: oklch(0.905 0.156 90.2);
  --color-yellow-600: oklch(0.681 0.162 75.8);  /* warning 기본 */
  --color-yellow-700: oklch(0.554 0.135 66.4);
  --color-yellow-800: oklch(0.476 0.114 61.9);
  --color-yellow-900: oklch(0.421 0.095 57.7);

  /* ── Mint (Info / Accent) — 100/300/600/900만 정의 ── */
  --color-mint-100: oklch(0.953 0.051 180.8);
  --color-mint-300: oklch(0.855 0.116 181.1);
  --color-mint-600: oklch(0.600 0.118 184.7);
  --color-mint-900: oklch(0.386 0.063 188.4);

  /* ── Orange — 100/300/600/900만 정의 ── */
  --color-orange-100: oklch(0.954 0.038 75.2);
  --color-orange-300: oklch(0.837 0.128 66.3);
  --color-orange-600: oklch(0.646 0.222 41.1);
  --color-orange-900: oklch(0.408 0.123 38.2);
}
```

> ⚠️ Green/Yellow/Mint/Orange는 DESIGN.md에 **정의된 step만** 채움. 없는 step(예: `mint-500`) 추가 금지.

---

## 2. Semantic Tokens (`:root`)

raw 팔레트를 alias 한 의미 토큰. 화면 구현 시 raw 보다 **시맨틱 토큰 우선**.
**컬러톤이 바뀌어도 이 매핑은 그대로** — blue/violet 슬롯 값만 갈리면 전부 따라온다.

```css
:root {
  /* 표면 / 텍스트 기본 */
  --primary: var(--color-blue-500);
  --background: var(--color-grey-50);
  --foreground: var(--color-grey-900);
  --popover: var(--color-grey-50);
  --popover-foreground: var(--color-grey-900);
  --muted-foreground: var(--color-grey-500);
  --accent: var(--color-grey-100);
  --hr-color: var(--color-grey-200);
  --ring: oklch(0.708 0 0);
  --border: var(--color-grey-200);
  --destructive: var(--color-red-500);
  --alert: var(--color-red-600);
  --warning: var(--color-yellow-600);

  /* Card */
  --card: var(--color-grey-00);
  --card-selected-background: var(--color-grey-100);
  --card-accent: var(--color-blue-500);
  --card-foreground: var(--color-grey-900);
  --card-border: var(--color-grey-200);

  /* Sidebar */
  --sidebar: var(--color-grey-50);
  --sidebar-foreground: var(--color-grey-600);
  --sidebar-icon: var(--color-grey-600);
  --sidebar-accent: var(--color-grey-200);
  --sidebar-accent-foreground: var(--color-grey-900);
  --sidebar-accent-icon: var(--color-blue-500);
  --sidebar-border: var(--color-grey-200);

  /* Input */
  --input: var(--color-grey-100);
  --input-placeholder: var(--color-grey-600);
  --input-border: var(--color-grey-300);
  --input-accent: var(--color-blue-500);
  --input-alert-border: var(--color-red-500);
  --input-alert-text: var(--color-red-600);

  /* Select */
  --select-background: var(--color-grey-100);
  --select-border: var(--color-grey-300);
  --select-foreground: var(--color-grey-900);
  --select-placeholder: var(--color-grey-600);
  --select-chevron: var(--color-grey-600);

  /* Button */
  --btn-alert: var(--color-red-600);
  --btn-active: var(--color-blue-600);
  --btn-foreground: var(--color-grey-00);
  --btn-cancel: var(--color-grey-00);
  --btn-outline-border: var(--color-grey-300);
  --btn-cancel-border: var(--color-grey-300);
  --btn-cancel-foreground: var(--color-grey-700);

  /* Checkbox List */
  --checkboxlist-background: var(--color-grey-50);
  --checkboxlist-hover-background: var(--color-grey-100);
  --checkboxlist-border: var(--color-grey-200);
  --checkboxlist-hover-border: var(--color-grey-300);
  --checkboxlist-checked-border: var(--color-blue-500);

  /* Modal */
  --modal-background: var(--color-grey-700);
}
```

---

## 3. 컬러톤 바꾸기 (프로젝트 수행 시)

- **시드 컬러로 자동**: `/setup-ui "#7C3AED"` → blue/violet 슬롯을 그 톤의 OKLCH 스케일로 재생성. 나머지는 그대로.
- **수동**: 위 `--color-blue-*`(Primary)·`--color-violet-*`(Secondary) 값만 원하는 색 스케일로 교체.
- **회사 디자인 시스템 export**: Figma Variables 값으로 이 파일 전체 교체(토큰명/구조 유지).
- 기능 색(red/green/yellow/mint/orange)은 특별한 이유 없으면 유지 — 상태 가독성 때문.
