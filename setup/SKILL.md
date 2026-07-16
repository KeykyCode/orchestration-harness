---
name: setup
description: 새 프로젝트를 시작하거나 스킬셋을 조합할 때 사용. create-react-app CLI처럼 질문으로 플랫폼(앱/웹)·스택(Flutter/Next/Vite)·백엔드(Supabase/Python)·옵션을 선택받아, common 모듈과 선택한 stacks/crosscutting 모듈을 프로젝트 .claude/로 조합 복사하고 컬러톤·초기 셋업까지 진행한다. "프로젝트 시작", "새 앱 만들기", "스킬 조합", "셋업"에 발동.
---

# Setup — 질문 기반 프로젝트 조합

> **언어: 모든 질문·안내·진행 메시지는 한국어로 한다.** (사용자가 명시적으로 다른 언어를 요청한 경우에만 예외.)

`create-react-app` CLI처럼 **질문 → 선택 → 모듈 조합 복사 → 초기 셋업**을 수행하라.
> ⚠️ 이건 **새 프로젝트 전용**(스캐폴딩 포함). **이미 진행 중인 기존 프로젝트에 붙이려면 `adopt` 스킬**을 써라(질문·스캐폴딩 없이 감지·비파괴 부착, conventions는 기존 코드에서 추출).

스킬셋 루트(= `$SRC`) = **이 SKILL.md의 상위 디렉토리**(당신이 클론/다운로드한 스킬셋 경로).
> 유지보수자(원본 관리자)에게는 이 루트가 Obsidian vault 실행본이다(편집·커밋은 거기서). 일반 사용자는 클론 경로면 된다.

모듈은 두 종류다:
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
    Q6. AI/LLM 기능?  →  [있음(RAG·에이전트·프롬프트) / 없음]   → 있으면 `ai-llm` 얹기
    Q7. 프로젝트 경로/이름?
```

**선택 판단 기준(물을 때 안내):**
- Q2(웹 범위): 랜딩·블로그·공개 콘텐츠로 검색 유입(SEO)+서버로직까지 한 레포 → **풀스택**. 외부 API에 붙는 로그인 뒤 대시보드/툴 → **클라이언트만**.
- Q3(백엔드): 인증·DB·스토리지가 표준 수준, 빠른 출시 → **Supabase**. 무거운 커스텀 서버 로직·직접 제어 → **Python(FastAPI)**. (Java·Go는 아직 모듈 없음 — 생기면 여기 추가.)
- Q4(풀스택 프론트): SEO/공개 콘텐츠 중요 → **Next**. SEO 무관한 내부 툴 → **Vite**. 애매하면 Next.
- Q3(클라이언트만 프론트): 대부분 **Vite**. SEO 필요하면 애초에 풀스택/Next 검토.
- Q6(AI/LLM): RAG·프롬프트·LLM 에이전트/그래프·eval이 프로젝트의 실질 관심사면 **있음** → `ai-llm`(프레임워크 중립 skill + `ai-engineer` 에이전트) 추가. 단순히 API 한 번 호출하는 정도면 **없음**.

## 2. 모듈 매핑 (선택 → 복사 대상)

**항상(common):** `common/workflow`(스킬 7 + agents 10, pm-orchestrator 포함) + `common/workflow/.tasks`
> `document-work`는 스택 무관 — 작업 마무리 시 사용자 Obsidian vault에 요약 정리(vault 없으면 무해하게 skip).
> `checkpoint`는 청크 끝에 `.tasks/resume.md`(재시작 스냅샷)를 갱신하고 세션 리셋을 권한다(컨텍스트 위생).

**AI/LLM 있음(Q6):** crosscutting에 `ai-llm` 추가 — 프레임워크 중립 skill + `ai-engineer` 에이전트(RAG·프롬프트·에이전트그래프·eval 전담, 스택 중립 `developer`가 못 잡는 관심사). 스택·백엔드 선택과 직교(어떤 조합에도 얹을 수 있음).

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
SRC="<스킬셋 루트: 이 SKILL.md의 상위 디렉토리 = 클론/다운로드 경로>"
DEST=<Q7 경로>
mkdir -p "$DEST/.claude/skills" "$DEST/.claude/agents"
# 공통(항상)
cp -r "$SRC"/common/workflow/{plan-features,design-ui,develop-task,test,iterate,document-work,checkpoint} "$DEST/.claude/skills/"
cp "$SRC"/common/workflow/agents/*.md "$DEST/.claude/agents/"
cp "$SRC"/common/workflow/working-principles.md "$DEST/.claude/"   # 에이전트 공용 인식론 참조(bare 이름으로 참조)
cp -r "$SRC"/common/workflow/.tasks "$DEST/"
# 선택 stacks (매핑대로 1~2개)
cp -r "$SRC"/stacks/<선택스택> "$DEST/.claude/skills/"
# 선택 crosscutting (매핑대로 0~N개) — skill은 skills/로, 모듈에 agents/가 있으면 그 md는 agents/로 분리
for m in <선택횡단들>; do
  cp -r "$SRC"/crosscutting/"$m" "$DEST/.claude/skills/"
  if [ -d "$SRC"/crosscutting/"$m"/agents ]; then
    cp "$SRC"/crosscutting/"$m"/agents/*.md "$DEST/.claude/agents/"
    rm -rf "$DEST/.claude/skills/$m/agents"   # 스킬 폴더 안 agents 하위는 제거(중복 방지)
  fi
done
```
> `ai-llm`을 선택하면 위 루프가 `ai-engineer` 에이전트를 `.claude/agents/`로, `ai-llm` skill을 `.claude/skills/`로 자동 분리한다.

## 4. 컬러톤 적용 (웹 프론트 한정)
`design-system`을 복사한 경우에만: 복사된 `$DEST/.claude/skills/design-system/tokens.md`에 **Q5 시드**를 적용(그 색으로 `--color-blue-*`/`--color-violet-*` OKLCH 스케일 생성). 기본이면 중립 유지.
> ⚠️ **공용 마스터(`$SRC/crosscutting/design-system/tokens.md`)는 절대 건드리지 마라.** 색 교체는 항상 *프로젝트로 복사된 사본*에서.

## 5. 스택 초기 셋업
복사된 stack 스킬의 **"셋업" 섹션**을 실행한다:
- `ts-vite-react`/`ts-next` → `create vite`/`create-next-app` + deps + `npx shadcn init`.
- `flutter-app` → `flutter create` + 핵심 패키지.
- `py-fastapi` → 프로젝트 스캐폴드 + deps.
풀스택(프론트+백 2스택)이면 각 stack의 셋업을 모두 실행한다. 그 stack이 폴더구조·레이어의 기준이 된다.

## 6. 완료
- 조합된 모듈 목록 출력 (stacks / crosscutting / common 구분)
- 다음: `/plan-features "만들 기능 설명"` 안내
