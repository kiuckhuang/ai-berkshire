#!/usr/bin/env bash
# apply-local-overrides.sh — 重新套用本地客製化（upstream 同步後執行）
#
# 用途：每次 git merge / reset 到 upstream 之後，跑一次本腳本即可恢復
# 本地約定，不需要手動解衝突。全部操作皆為冪等（重複執行安全）。
#
# 目前包含的本地覆蓋：
#   1. 報告輸出路徑 reports/ → local/reports/（CLAUDE.md + 各 skill）
#      - local/ 已在 .gitignore，用來存放私人報告，與 upstream 公開 reports/ 區隔
#
# 不涵蓋（屬於新增檔案，不會與 upstream 衝突，無需重套）：
#   - skills/short-mid-term-investment.md（本地新 skill）
#   - CLAUDE.md / AGENTS.md 的「輸出語言：繁體中文（香港）」章節
#     （若 upstream 剛好改到同一段落產生衝突，保留本地章節即可）
set -euo pipefail
cd "$(dirname "$0")/.."

FILES=(
  CLAUDE.md
  skills/bottleneck-hunter.md
  skills/deep-company-series.md
  skills/earnings-review.md
  skills/earnings-team.md
  skills/income-investment.md
  skills/industry-funnel.md
  skills/management-deep-dive.md
  skills/news-pulse.md
  skills/portfolio-review.md
  skills/private-company-research.md
  skills/thesis-drift.md
  skills/thesis-tracker.md
  skills/wechat-article.md
)

# GNU sed 不支援 lookbehind：先把 local/reports/ 換成佔位符，取代後再還原
protect() { sed -i 's|local/reports/|\x01REPORTS\x01|g' "$1"; }
restore() { sed -i 's|\x01REPORTS\x01|local/reports/|g' "$1"; }

changed=0
for f in "${FILES[@]}" skills/investment-research.md; do
  [[ -f "$f" ]] || { echo "skip (missing): $f"; continue; }
  protect "$f"
  if grep -q 'reports/' "$f"; then
    sed -i 's|reports/|local/reports/|g' "$f"
    echo "updated: $f"
    changed=1
  fi
  restore "$f"
done

# investment-research.md 需要兩處額外處理：
#   1. 例外保留：引用 upstream 追蹤檔案 reports/7公司10年投资价值横评-... 不可改
#   2. 輸出路徑 ~/[公司名]投资研究报告.md → local/reports/（不含 "reports/" 字串，主迴圈抓不到）
f=skills/investment-research.md
if [[ -f "$f" ]]; then
  sed -i 's|local/reports/7公司10年投资价值横评|reports/7公司10年投资价值横评|g' "$f"
  sed -i 's|`~/\[公司名\]投资研究报告\.md`|`local/reports/[公司名]投资研究报告.md`|g' "$f"
fi

if [[ "$changed" == "1" ]]; then
  echo
  echo "完成。如 skills/ 有變動，請接著執行："
  echo "  python3 scripts/sync-codex-skills.py && python3 scripts/sync-codex-prompts.py"
else
  echo "所有檔案已是本地約定，無需修改。"
fi
