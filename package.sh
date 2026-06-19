#!/usr/bin/env bash
# 조직 스킬 업로드용 자기완결 패키지 재생성.
# 모듈(common/stacks/crosscutting)을 dist/mapia-setup/assets/ 로 번들 + zip.
# dist/mapia-setup/SKILL.md (조직 배포판, $SRC=스킬자신/assets)는 손대지 않는다.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
PKG="$ROOT/dist/mapia-setup"

[ -f "$PKG/SKILL.md" ] || { echo "ERROR: $PKG/SKILL.md 없음 (조직 배포판 SKILL.md를 먼저 둬라)"; exit 1; }

rm -rf "$PKG/assets"
mkdir -p "$PKG/assets"
cp -r "$ROOT/common"       "$PKG/assets/common"
cp -r "$ROOT/stacks"       "$PKG/assets/stacks"
cp -r "$ROOT/crosscutting" "$PKG/assets/crosscutting"

cd "$ROOT/dist"
rm -f mapia-setup.zip
zip -rq mapia-setup.zip mapia-setup -x '*.DS_Store'

echo "✅ dist/mapia-setup.zip 재생성 ($(du -h mapia-setup.zip | cut -f1))"
echo "   업로드: 조직 설정 → 스킬 → 조직 스킬 → 스킬 업로드"
