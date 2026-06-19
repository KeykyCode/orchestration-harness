#!/usr/bin/env bash
# 스킬셋 동기화 — 개발 레포(원본) ↔ 프로젝트 .claude/ 사본.
#
# 프로젝트는 평면 레이아웃(.claude/skills/<모듈>, .claude/agents/<파일>)이고
# 개발 레포는 stacks/ · crosscutting/ · common/workflow/ 로 나뉘어 있어,
# 이 스크립트가 모듈 이름으로 양쪽을 매핑해 diff/복사한다.
#
# 사용법:
#   ./sync.sh diff <프로젝트경로>     # (기본·안전) 양쪽 차이만 출력. 아무것도 안 바꿈
#   ./sync.sh pull <프로젝트경로>     # 레포 → 프로젝트  (기존 프로젝트를 최신 규칙으로 갱신)
#   ./sync.sh push <프로젝트경로>     # 프로젝트 → 레포  (개발 중 보강한 내용 역류). --force 필요
#
# push는 레포 원본을 덮으므로 위험 → 항상 먼저 `diff`로 확인하고, 의도한 변경만 역류시켜라.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
CMD="${1:-diff}"
PROJ="${2:-}"
FORCE="${3:-}"

[ -n "$PROJ" ] || { echo "사용법: ./sync.sh {diff|pull|push} <프로젝트경로> [--force]"; exit 1; }
PCLAUDE="$PROJ/.claude"
[ -d "$PCLAUDE/skills" ] || { echo "ERROR: $PCLAUDE/skills 없음 — 스킬셋이 깔린 프로젝트가 맞나?"; exit 1; }

# 모듈 이름 → 개발 레포 내 경로 (stacks / crosscutting / common/workflow 순으로 탐색)
repo_home() {
  local name="$1"
  for base in stacks crosscutting common/workflow; do
    [ -d "$ROOT/$base/$name" ] && { echo "$ROOT/$base/$name"; return 0; }
  done
  return 1
}

# (레포경로, 프로젝트경로) 쌍을 모두 나열 → "REPO|PROJ" 라인
pairs() {
  # 모듈 (skills 하위 디렉토리)
  for d in "$PCLAUDE"/skills/*/; do
    [ -d "$d" ] || continue
    local name; name="$(basename "$d")"
    local home; if home="$(repo_home "$name")"; then echo "$home|${d%/}"; else
      echo "  ⚠️  레포에 없는 모듈: $name (프로젝트 전용? 건너뜀)" >&2
    fi
  done
  # 에이전트 (개별 파일)
  for f in "$PCLAUDE"/agents/*.md; do
    [ -e "$f" ] || continue
    local rf="$ROOT/common/workflow/agents/$(basename "$f")"
    [ -e "$rf" ] && echo "$rf|$f" || echo "  ⚠️  레포에 없는 에이전트: $(basename "$f")" >&2
  done
}

case "$CMD" in
  diff)
    echo "=== diff: 개발레포(<) vs 프로젝트(>) — $PROJ ==="
    n=0
    while IFS='|' read -r repo proj; do
      if diff -rq "$repo" "$proj" >/dev/null 2>&1; then :; else
        echo "--- ▲ $(basename "$repo") ---"
        diff -ru "$repo" "$proj" 2>/dev/null || true
        n=$((n+1))
      fi
    done < <(pairs)
    [ "$n" -eq 0 ] && echo "차이 없음 (완전 동기 상태)" || echo "=== 차이 있는 항목: $n ==="
    ;;
  pull)
    echo "=== pull: 레포 → 프로젝트 (프로젝트 사본을 최신 규칙으로 갱신) ==="
    while IFS='|' read -r repo proj; do
      if [ -d "$proj" ]; then cp -r "$repo"/. "$proj"/; else cp "$repo" "$proj"; fi
      echo "  ↓ $(basename "$proj")"
    done < <(pairs)
    echo "완료. (프로젝트에서 변경했던 로컬 수정은 덮였을 수 있음 — 필요시 git diff 확인)"
    ;;
  push)
    [ "$FORCE" = "--force" ] || { echo "⚠️  push는 레포 원본을 덮는다. 먼저 './sync.sh diff $PROJ' 로 확인 후, 확실하면 '--force' 붙여 재실행."; exit 1; }
    echo "=== push: 프로젝트 → 레포 (보강 내용 역류) ==="
    while IFS='|' read -r repo proj; do
      if [ -d "$proj" ]; then cp -r "$proj"/. "$repo"/; else cp "$proj" "$repo"; fi
      echo "  ↑ $(basename "$proj") → $repo"
    done < <(pairs)
    echo "완료. 레포에서 git diff 로 검토 후 커밋하라. 모듈 배포 반영은 ./package.sh + 재업로드."
    ;;
  *)
    echo "알 수 없는 명령: $CMD (diff|pull|push)"; exit 1;;
esac
