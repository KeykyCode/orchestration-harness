---
name: setup
description: 새 프로젝트를 시작하거나 스킬셋을 조합할 때 사용. create-react-app CLI처럼 질문으로 플랫폼(앱/웹)·스택(Flutter/Next/Vite)·백엔드(Supabase/Python)·옵션을 선택받아, 이 스킬에 번들된 common 모듈과 선택한 stacks/crosscutting 모듈을 프로젝트 .claude/로 조합 복사하고 컬러톤·초기 셋업까지 진행한다. "프로젝트 시작", "새 앱 만들기", "스킬 조합", "셋업"에 발동.
---

# Setup — 질문 기반 프로젝트 조합 (자기완결 / 조직 배포판)

> **언어: 모든 질문·안내·진행 메시지는 한국어로 한다.** (사용자가 명시적으로 다른 언어를 요청한 경우에만 예외.)

`create-react-app` CLI처럼 **질문 → 선택 → 모듈 조합 복사 → 초기 셋업**을 수행하라.

## 0. 스킬셋 루트 확정 (먼저 한다)

이 스킬에는 모듈이 **`assets/` 하위에 번들**돼 있다(`assets/common`, `assets/stacks`, `assets/crosscutting`).
각 모듈의 스킬 파일은 **`MODULE.md`** 라는 이름으로 들어 있다(조직 업로더가 zip 당 `SKILL.md` 1개만 허용하므로). 복사할 땐 그대로 가져오고, 3번에서 프로젝트로 옮긴 뒤 `SKILL.md`로 되돌린다.
복사 전에 **이 SKILL.md가 위치한 디렉토리의 절대경로**를 알아내 `$SRC`로 잡아라.

```bash
# 이 SKILL.md(=현재 스킬)가 풀려 있는 실제 디렉토리를 SKILL_DIR 로 지정한다.
#   - Claude Code가 이 스킬을 로드한 경로를 그대로 쓴다(보통 SKILL.md가 든 폴더).
#   - 모르면: `find ~ -name SKILL.md -path '*project-setup*' 2>/dev/null` 등으로 확인.
SKILL_DIR="<이 SKILL.md가 있는 디렉토리의 절대경로>"
SRC="$SKILL_DIR/assets"          # 번들 루트
test -d "$SRC/common" && test -d "$SRC/stacks" || { echo "assets 번들을 못 찾음 — SKILL_DIR 재확인"; }
```

모듈은 세 종류다:
- **stacks/** — 언어·프레임워크 종속(폴더구조·명명·셋업). 질문으로 **1~2개** 고른다(풀스택이면 프론트1+백1).
- **crosscutting/** — 스택 중립 횡단 관심사(인증 원칙·서버상태·fetch·디자인). **0~N개** 얹는다.
- **common/workflow** — 진짜 스택 중립. **항상** 복사.

## 1. 질문 (결정 트리대로 순서대로 물어라)

```
Q1. 앱 / 웹?
│
├─ 앱
│   └─ Q2. 프레임워크?  →  [Flutter]            (현재 1택)
│       └─ Q3. 백엔드?  →  [Supabase / Python(FastAPI) / 없음]   ┐
│                                                                 ├─ 공유 노드
└─ 웹                                                             │
    └─ Q2. 범위?  →  [풀스택 / 클라이언트만]                      │
        │                                                         │
        ├─ 풀스택                                                 │
        │   ├─ Q3. 백엔드?  →  [Supabase / Python(FastAPI)]  ─────┘
        │   └─ Q4. 프론트?  →  [Next / Vite]
        │                                                  (Java·Go 백엔드는 미구현 → 메뉴에 노출 안 함)
        └─ 클라이언트만
            └─ Q3. 프론트 스택?  →  [Vite / Next]
└─ (마지막 공통)
    Q5. 컬러 시드?  →  [HEX 예: #7c6bff / 기본(중립)]   ※ 웹 프론트일 때만
    Q6. 프로젝트 경로/이름?
```

**선택 판단 기준(물을 때 안내):**
- Q2(웹 범위): 랜딩·블로그·공개 콘텐츠로 검색 유입(SEO)+서버로직까지 한 레포 → **풀스택**. 외부 API에 붙는 로그인 뒤 대시보드/툴 → **클라이언트만**.
- Q3(백엔드): 인증·DB·스토리지가 표준 수준, 빠른 출시 → **Supabase**. 무거운 커스텀 서버 로직·직접 제어 → **Python(FastAPI)**. (Java·Go는 아직 모듈 없음 — 생기면 여기 추가.)
- Q4(풀스택 프론트): SEO/공개 콘텐츠 중요 → **Next**. SEO 무관한 내부 툴 → **Vite**. 애매하면 Next.
- Q3(클라이언트만 프론트): 대부분 **Vite**. SEO 필요하면 애초에 풀스택/Next 검토.

## 2. 모듈 매핑 (선택 → 복사 대상)

**항상(common):** `common/workflow`(스킬 5 + agents 7, pm-orchestrator 포함) + `common/workflow/.tasks`

| 선택 조합 | stacks | crosscutting |
|---|---|---|
| 앱 + Supabase | `flutter-app` | `supabase-auth` |
| 앱 + Python | `flutter-app` + `py-fastapi` | `api-client` |
| 앱 + 백엔드 없음 | `flutter-app` | — |
| 풀스택웹 + Supabase + Next | `ts-next` | `supabase-auth`, `design-system` (+ 클라 페칭 시 `tanstack-query`) |
| 풀스택웹 + Supabase + Vite | `ts-vite-react` | `supabase-auth`, `design-system`, `tanstack-query` |
| 풀스택웹 + Python + Next | `ts-next` + `py-fastapi` | `api-client`, `design-system` (+ `tanstack-query`) |
| 풀스택웹 + Python + Vite | `ts-vite-react` + `py-fastapi` | `api-client`, `design-system`, `tanstack-query` |
| 클라이언트만 + Vite | `ts-vite-react` | `api-client`, `design-system`, `tanstack-query` |
| 클라이언트만 + Next | `ts-next` | `api-client`, `design-system` (+ `tanstack-query`) |

> 규칙: **stacks에서 1개(풀스택·앱+Python이면 프론트/앱 1 + 백 1) + crosscutting N개 + common 항상.**
> `design-system`은 **웹 프론트일 때만** 복사(Flutter는 자체 디자인 가이드 내장, Python 백엔드는 UI 없음).
> 중복 모듈(`api-client` 등)은 한 번만 복사.

## 3. 복사 실행

```bash
# SRC 는 0번에서 확정한 "$SKILL_DIR/assets"
DEST=<Q6 경로>
mkdir -p "$DEST/.claude/skills" "$DEST/.claude/agents"
# 공통(항상)
cp -r "$SRC"/common/workflow/{plan-features,design-ui,develop-task,test,iterate} "$DEST/.claude/skills/"
cp "$SRC"/common/workflow/agents/*.md "$DEST/.claude/agents/"
cp -r "$SRC"/common/workflow/.tasks "$DEST/"
# 선택 stacks (매핑대로 1~2개)
cp -r "$SRC"/stacks/<선택스택> "$DEST/.claude/skills/"
# 선택 crosscutting (매핑대로 0~N개)
cp -r "$SRC"/crosscutting/<선택횡단> "$DEST/.claude/skills/"

# ⚠️ 번들 안 모듈 스킬 파일은 MODULE.md 로 들어있다(조직 업로더가 SKILL.md 1개만 허용해서).
#    프로젝트로 복사한 뒤 SKILL.md 로 되돌려야 Claude Code가 스킬로 인식한다.
find "$DEST/.claude/skills" -name MODULE.md | while read -r f; do mv "$f" "$(dirname "$f")/SKILL.md"; done
```

## 4. 컬러톤 적용 (웹 프론트 한정)
`design-system`을 복사한 경우에만: 복사된 `$DEST/.claude/skills/design-system/tokens.md`에 **Q5 시드**를 적용(그 색으로 `--color-blue-*`/`--color-violet-*` OKLCH 스케일 생성). 기본이면 중립 유지.
> ⚠️ **번들 마스터(`$SRC/crosscutting/design-system/tokens.md`)는 절대 건드리지 마라.** 색 교체는 항상 *프로젝트로 복사된 사본*에서.

## 5. 스택 초기 셋업
복사된 stack 스킬의 **"셋업" 섹션**을 실행한다:
- `ts-vite-react`/`ts-next` → `create vite`/`create-next-app` + deps + `npx shadcn init`.
- `flutter-app` → `flutter create` + 핵심 패키지.
- `py-fastapi` → 프로젝트 스캐폴드 + deps.
풀스택(프론트+백 2스택)이면 각 stack의 셋업을 모두 실행한다. 그 stack이 폴더구조·레이어의 기준이 된다.

## 6. 완료
- 조합된 모듈 목록 출력 (stacks / crosscutting / common 구분)
- 다음: `/plan-features "만들 기능 설명"` 안내
