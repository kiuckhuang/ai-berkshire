#!/usr/bin/env bash
# install-dsh-skills.sh — 把本倉庫的 skills 安裝進 DeepSeek Harness 使用者 skill 根目錄
#
# DSH 會即時掃描 ~/.dsh/skills/<name>/SKILL.md（使用者全域層，所有 session / preset 可見）。
# 本腳本對 codex-skills/<name>/（由 sync-codex-skills.py 從 skills/*.md 生成，
# 已含 DSH 需要的 frontmatter）逐一建立 symlink，因此：
#   - 倉庫更新（make sync / make codex）後，DSH 立即看到最新內容，無需重跑本腳本
#   - 新增 skill 後才需要重跑一次（建立新 link）
#
# 冪等，可重複執行。使用方式：make dsh-skill
set -euo pipefail
cd "$(dirname "$0")/.."

ROOT="$(pwd)"
DSH_SKILLS="${DSH_HOME:-$HOME/.dsh}/skills"
mkdir -p "$DSH_SKILLS"

# 先確保 codex-skills 是最新的
python3 scripts/sync-codex-skills.py >/dev/null

installed=0
for dir in codex-skills/*/; do
  name="$(basename "$dir")"
  [[ -f "$dir/SKILL.md" ]] || continue
  ln -sfn "$ROOT/codex-skills/$name" "$DSH_SKILLS/$name"
  installed=$((installed + 1))
done

# 清掉指向本倉庫但目標已消失的舊 link
pruned=0
for link in "$DSH_SKILLS"/*; do
  [[ -L "$link" ]] || continue
  target="$(readlink "$link")"
  if [[ "$target" == "$ROOT/"* && ! -e "$link" ]]; then
    rm "$link"
    pruned=$((pruned + 1))
  fi
done

echo "✅ 已安裝 $installed 個 DSH skills 到 $DSH_SKILLS（symlink → $ROOT/codex-skills/）"
[[ "$pruned" == "0" ]] || echo "   清理了 $pruned 個失效 link"
echo "   新開的 DSH session 立即可用（skill 目錄即時掃描，無需重啟）"
