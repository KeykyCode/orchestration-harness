---
name: update
description: 이미 스킬셋이 깔린(setup/adopt 완료) 프로젝트의 워크플로 스킬·에이전트를 최신 스킬셋으로 갱신할 때 사용. "스킬 최신으로 갱신", "이 프로젝트 .claude 업데이트", "harness 새 버전 반영", "update"에 발동. harness 관리분만 덮어쓰고 프로젝트 고유(conventions·상태·CLAUDE.md·색 커스텀)는 보존. 스택 무관.
---

# Update — 기존 도입 프로젝트를 최신 스킬셋으로 갱신 (harness 관리분만 덮어쓰기)

> `setup`(새 프로젝트)·`adopt`(기존 프로젝트 도입)의 세 번째 형제. **이미 깔린 사본**을 최신으로.
> 프로젝트 `.claude/` 스킬은 깔던 시점에 **동결**된다 — 이 스킬이 그걸 새로고침한다.
> `$SRC` = 이 SKILL.md의 상위 디렉토리(클론/다운로드한 스킬셋 루트). 유지보수자는 vault 실행본.

## 0. 대원칙
- **소스 먼저 최신**: 팀원이면 갱신 전 `git -C "$SRC" pull`로 스킬셋 클론을 최신화한다(안 하면 옛 버전으로 덮음).
- **harness 관리분만 덮어쓰기**: 공용 워크플로 스킬·에이전트·원칙만. **프로젝트 고유는 절대 안 건드림.**
- ⚠️ `adopt`는 `cp -n`(비파괴)이라 **갱신용이 아니다**(기존 파일 안 덮음). 갱신은 이 스킬로.

## 1. 보존 vs 갱신 (핵심)
| 보존 (덮지 않음) | 갱신 (덮어씀) |
|---|---|
| `.claude/skills/conventions/`(프로젝트별 추출본) | 공용 워크플로 스킬 7종 |
| `.tasks/*.md` **내용**(라이브 상태) | `agents/*.md` |
| `CLAUDE.md` · `settings.local.json` | `working-principles.md` |
| `design-system/tokens.md`(색 커스텀) | 설치된 crosscutting 모듈(색 제외) |

## 2. 실행
```bash
SRC="<스킬셋 루트: 이 SKILL.md의 상위 = 클론 경로>"   # 팀원: 먼저 git -C "$SRC" pull
DEST=<대상 프로젝트 경로>

# 공용 워크플로 스킬·에이전트·원칙 덮어쓰기 (프로젝트 고유 아님)
cp -r "$SRC"/common/workflow/{plan-features,design-ui,develop-task,test,iterate,document-work,checkpoint} "$DEST/.claude/skills/"
cp    "$SRC"/common/workflow/agents/*.md "$DEST/.claude/agents/"
cp    "$SRC"/common/workflow/working-principles.md "$DEST/.claude/"

# resume.md 템플릿: 없을 때만 (라이브 상태 보존, .tasks 내용은 안 덮음)
[ -f "$DEST/.tasks/resume.md" ] || cp "$SRC"/common/workflow/.tasks/resume.md "$DEST/.tasks/"

# 이미 설치된 crosscutting 모듈만 갱신 (새 모듈 추가는 adopt 소관)
for m in "$DEST"/.claude/skills/*/; do
  name=$(basename "$m")
  [ -d "$SRC"/crosscutting/"$name" ] || continue
  if [ "$name" = "design-system" ]; then
    cp "$SRC"/crosscutting/design-system/SKILL.md "$DEST/.claude/skills/design-system/"   # tokens.md(색)는 보존
  else
    cp -r "$SRC"/crosscutting/"$name" "$DEST/.claude/skills/"
    if [ -d "$SRC"/crosscutting/"$name"/agents ]; then
      cp "$SRC"/crosscutting/"$name"/agents/*.md "$DEST/.claude/agents/"
      rm -rf "$DEST/.claude/skills/$name/agents"
    fi
  fi
done
```

## 3. 세션 재시작 안내 (필수)
새 스킬은 **세션 시작 때 로드**된다. 갱신 후 그 대화를 **새로 시작(또는 `/clear`)** 해야 새 스킬(`/checkpoint` 등)이 인식된다.
진행 중이던 상태는 갱신 전에 `checkpoint`로 `resume.md`에 적어두고, 새 세션에서 그것부터 읽고 이어가면 매끄럽다.

## 4. 완료 보고
- 갱신된 것(스킬·에이전트 목록)과 **보존된 것**(conventions·.tasks 상태·CLAUDE.md·색)을 구분해 보고.
- 새 모듈을 이 프로젝트에 **처음 추가**하려는 거면 이 스킬이 아니라 `adopt`(감지·부착)를 쓰라고 안내.
