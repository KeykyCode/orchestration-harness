---
name: adopt
description: 이미 진행 중인(기존) 프로젝트에 이 워크플로 스킬셋을 부착할 때 사용. setup과 달리 스캐폴딩·스택 질문 없이 — 스택을 감지하고, 스택 중립 workflow를 비파괴로 얹고, conventions는 이식하지 않고 기존 코드/CLAUDE.md에서 추출해 생성한다. "기존 프로젝트에 워크플로 붙여줘", "이 레포에 스킬셋 도입", "adopt"에 발동.
---

# Adopt — 기존 프로젝트에 워크플로 부착 (비파괴)

> `setup`(새 프로젝트 스캐폴딩)의 형제. 원칙: **질문 대신 감지 · 스캐폴딩 없음 · 규칙은 이식이 아니라 추출.**
> `$SRC`(원천) = `/Users/ravi/Documents/Obsidian Vault/공통-SKILLS/v1-skill-setup`.
> **언어: 모든 안내·진행 메시지는 한국어로.**

## 0. 대원칙 (어기지 말 것)
- **비파괴**: 기존 `CLAUDE.md`·`.claude/`·소스를 절대 덮어쓰지 않는다(병합·신설만). 스캐폴딩(`create-*`·`flutter create`) 금지 — 프로젝트는 이미 있다.
- **실제 우선**: 우리 stack 스킬의 의견(예: "Zustand 금지")을 강요하지 않는다. 기존 코드가 다르면 **기존 코드가 정답**. conventions는 이식이 아니라 추출한다.

## 1. 스택·의존성 감지 (질문 최소화)
DEST의 매니페스트를 읽어 판별한다:
- `package.json` → `react`+`vite` / `next` 구분. 의존성: `@tanstack/react-query`→`tanstack-query`, `@supabase/supabase-js`→`supabase-auth`, `langchain`·`@langchain/*`·`openai`·`ai`(Vercel AI SDK)·`llamaindex`→`ai-llm`
- `pubspec.yaml` → `flutter-app` / `supabase_flutter`→`supabase-auth`
- `pyproject.toml`·`requirements.txt` → `fastapi`→`py-fastapi` / `langchain`·`openai`→`ai-llm`
애매할 때만 사용자에게 확인한다.

## 2. 부착 (복사, 비파괴)
```bash
SRC="/Users/ravi/Documents/Obsidian Vault/공통-SKILLS/v1-skill-setup"
DEST=<기존 프로젝트 경로>
mkdir -p "$DEST/.claude/skills" "$DEST/.claude/agents"
# workflow는 스택 중립 → 항상 안전하게 부착 (-n: 기존 파일 건드리지 않음)
cp -rn "$SRC"/common/workflow/{plan-features,design-ui,develop-task,test,iterate,document-work} "$DEST/.claude/skills/"
cp -n  "$SRC"/common/workflow/agents/*.md "$DEST/.claude/agents/"
cp -rn "$SRC"/common/workflow/.tasks "$DEST/" 2>/dev/null || true
# 감지된 crosscutting만 (모듈에 agents/ 있으면 .claude/agents/로 분리)
for m in <감지된 crosscutting들>; do
  cp -rn "$SRC"/crosscutting/"$m" "$DEST/.claude/skills/"
  if [ -d "$SRC"/crosscutting/"$m"/agents ]; then
    cp -n "$SRC"/crosscutting/"$m"/agents/*.md "$DEST/.claude/agents/"
    rm -rf "$DEST/.claude/skills/$m/agents"
  fi
done
```

## 3. conventions 확립 (핵심 — 이식이 아니라 추출)
workflow는 "현 프로젝트 conventions 스킬"을 1순위로 가리킨다. 기존 프로젝트엔 그 **원천을 새로 만들어** 준다: `.claude/skills/conventions/SKILL.md` 를 **실제 코드에서 추출**해 생성한다. workflow가 기대하는 섹션 뼈대(`## 태스크 태그`, `## 검증`, 레이어 규칙, 명명)를 갖되, 값은 이 프로젝트의 실제로 채운다.

1. 감지된 stack 스킬(`stacks/<스택>/SKILL.md`)은 **섹션 뼈대 템플릿으로만** 참고.
2. 값은 프로젝트에서 읽는다:
   - `## 검증` = 실제 lint/test/build 명령(`package.json` scripts·`Makefile`·CI 워크플로에서).
   - 레이어·폴더구조·명명 = 실제 디렉토리와 대표 파일 몇 개를 읽어 귀납.
   - `## 태스크 태그` = 실제 레이어에 맞춰(억지로 우리 태그 강요 X).
3. 기존 `CLAUDE.md`가 있으면 그 규칙을 흡수하되 **CLAUDE.md는 그대로 둔다**(conventions는 그것을 보완·구조화한 것).
4. 우리 stack 스킬 의견과 실제가 **충돌하면 실제를 적고**, 차이는 "권고"로만 주석(강요 X).
5. `CLAUDE.md`가 아예 없으면 코드 요약으로 최소 conventions만 만들고, 사용자에게 `/init`(CLAUDE.md 생성)을 권한다.

## 4. 스캐폴딩·초기셋업 (건너뜀)
`setup` step 5(스택 생성·deps 설치)는 **하지 않는다**. 기존 프로젝트가 기준이다.

## 5. 완료
- 부착 결과 보고: workflow 스킬·에이전트·crosscutting·생성한 `conventions` 경로.
- **기존 파일은 하나도 안 건드렸음**을 명시(`.claude` 병합 결과만).
- 다음: `/plan-features "다음 기능"` 또는 pm-orchestration으로 바로 시작 가능.
