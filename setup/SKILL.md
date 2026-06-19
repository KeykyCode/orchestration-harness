---
name: setup
description: 새 프로젝트를 시작하거나 스킬셋을 조합할 때 사용. create-react-app CLI처럼 질문으로 스택(Vite/Next)·백엔드(Supabase)·옵션을 선택받아, common 모듈과 선택한 modules를 프로젝트 .claude/로 조합 복사하고 컬러톤·초기 셋업까지 진행한다. "프로젝트 시작", "새 앱 만들기", "스킬 조합", "셋업"에 발동.
---

# Setup — 질문 기반 프로젝트 조합

`create-react-app` CLI처럼 **질문 → 선택 → 모듈 조합 복사 → 초기 셋업**을 수행하라.
스킬셋 루트는 `/Users/ravi/work_space/skill-sets/v1-skill-setup` (= `$SRC`).

## 1. 질문 (순서대로 사용자에게 물어라)

```
Q1. 무엇을 개발하나요?       [프론트엔드 / 백엔드 / 풀스택]
Q2. (프론트) 어떤 스택?       [Vite + React (SPA) / Next.js (SEO)]
Q3. 데이터/백엔드?           [Supabase / 직접 REST API / 없음]
Q4. 서버상태 관리 추가?       [TanStack Query / 안 함]
Q5. 컬러 시드?               [HEX 예: #7c6bff / 기본(중립)]
Q6. 프로젝트 경로/이름?
```

**선택 판단 기준(물을 때 안내):**
- Q2: 랜딩·블로그·공개 콘텐츠로 검색 유입(SEO)이 핵심 → **Next**. 로그인 뒤 대시보드·툴, SEO 무관 → **Vite**. 애매하면 Next(SEO는 나중에 SPA로 되돌리기 어렵다).
- Q3: 인증·DB·스토리지가 표준 수준, 빠른 출시 → **Supabase**. 무거운 커스텀 서버 로직 → 별도 백엔드.
- Q4: Vite는 권장(서버상태=Query). Next는 RSC가 우선이라 *클라 페칭 필요할 때만*.

## 2. 모듈 매핑 (선택 → 복사 대상)

**항상(common):** `common/design-system`, `common/workflow`(스킬 5 + agents 6), `common/workflow/.tasks`

| 선택 | 추가 modules |
|---|---|
| Front = Vite | `vite-react-conventions` + `api-client` |
| Front = Next | `next-conventions` |
| 데이터 = Supabase | `supabase-auth` |
| 데이터 = 직접 REST | `api-client` (중복이면 한 번만) |
| 서버상태 = Query | `tanstack-query` |

## 3. 복사 실행

```bash
SRC=/Users/ravi/work_space/skill-sets/v1-skill-setup
DEST=<Q6 경로>
mkdir -p "$DEST/.claude/skills" "$DEST/.claude/agents"
# 공통(항상)
cp -r "$SRC"/common/design-system "$DEST/.claude/skills/"
cp -r "$SRC"/common/workflow/{plan-features,design-ui,develop-task,test,iterate} "$DEST/.claude/skills/"
cp "$SRC"/common/workflow/agents/*.md "$DEST/.claude/agents/"
cp -r "$SRC"/common/workflow/.tasks "$DEST/"
# 선택 모듈(매핑대로, 골라서)
cp -r "$SRC"/modules/<선택1> "$DEST/.claude/skills/"
cp -r "$SRC"/modules/<선택2> "$DEST/.claude/skills/"
```

## 4. 컬러톤 적용
복사된 `$DEST/.claude/skills/design-system/tokens.md`에 **Q5 시드**를 적용(그 색으로 `--color-blue-*`/`--color-violet-*` OKLCH 스케일 생성). 기본이면 중립 유지.
> ⚠️ **공용 마스터(`$SRC/common/design-system/tokens.md`)는 절대 건드리지 마라.** 색 교체는 항상 *프로젝트로 복사된 사본*에서.

## 5. 스택 초기 셋업
복사된 conventions 스킬(`vite-react-conventions` 또는 `next-conventions`)의 **"셋업" 섹션**을 실행한다 (`create-next-app`/`create vite` + deps + `npx shadcn init`). 그 conventions가 폴더구조·레이어의 기준이 된다.

## 6. 완료
- 조합된 모듈 목록 출력
- 다음: `/plan-features "만들 기능 설명"` 안내
