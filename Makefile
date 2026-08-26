# AI Berkshire — 本地維護捷徑
# 用法：直接打 `make` 顯示所有可用指令

.DEFAULT_GOAL := help

.PHONY: help init fetch sync overrides codex check test push

init: ## 初始化環境：檢查 python3/make，安裝可選依賴 playwright（xueqiu_scraper 用；SKIP_PLAYWRIGHT=1 可跳過）
	@command -v python3 >/dev/null || { echo "❌ 需要 python3"; exit 1; }
	@command -v make >/dev/null || { echo "❌ 需要 make"; exit 1; }
	@python3 -c "import sys; v=sys.version_info; assert v >= (3, 8), f'需要 Python ≥ 3.8，目前 {v.major}.{v.minor}'"
	@echo "✅ python3 $$(python3 --version | cut -d' ' -f2)、make 就緒"
	@echo "核心工具（tools/*.py、scripts/*.py、tests/）全部零第三方依賴，無需額外安裝"
ifneq ($(SKIP_PLAYWRIGHT),1)
	@if python3 -c "import playwright" 2>/dev/null; then \
		echo "✅ playwright 已安裝（可選依賴，xueqiu_scraper 用）"; \
	else \
		echo "安裝可選依賴 playwright（tools/xueqiu_scraper.py 雪球爬蟲用）..."; \
		python3 -m pip install --user playwright && \
			python3 -m playwright install chromium || \
			echo "⚠️  playwright 安裝失敗（可選依賴，不影響核心功能）。用到 xueqiu_scraper 時再跑：python3 -m pip install --user playwright && python3 -m playwright install chromium"; \
	fi
else
	@echo "已跳過 playwright（SKIP_PLAYWRIGHT=1）"
endif
	@$(MAKE) --no-print-directory test

help: ## 顯示本說明（預設指令）
	@echo "AI Berkshire 本地維護指令："
	@echo
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  make %-12s %s\n", $$1, $$2}'
	@echo
	@echo "典型流程："
	@echo "  make sync     # 每次同步 upstream 用這一個就夠"
	@echo "  make push     # 確認無誤後推送"

fetch: ## 抓取 origin 與 upstream 最新提交
	git fetch origin
	git fetch upstream

sync: fetch ## 一鍵同步：合併 upstream/main → 重套本地覆蓋 → 重新生成 codex 產物 → 一致性檢查
	git merge --no-edit upstream/main || { \
		echo; \
		echo "⚠️  合併有衝突。手動解完後接著跑："; \
		echo "    git add -A && git commit --no-edit"; \
		echo "    make overrides codex check"; \
		exit 1; \
	}
	bash scripts/apply-local-overrides.sh
	python3 scripts/sync-codex-skills.py
	python3 scripts/sync-codex-prompts.py
	$(MAKE) check
	@echo
	@echo "✅ 同步完成。若有產物變動：git add -A && git commit -m '同步 upstream'"
	@git status --short

overrides: ## 只重套本地覆蓋（local/reports 路徑約定等）
	bash scripts/apply-local-overrides.sh

codex: ## 只重新生成 codex-skills 與 codex-prompts
	python3 scripts/sync-codex-skills.py
	python3 scripts/sync-codex-prompts.py

check: ## 檢查 codex 產物是否與 skills/ 一致（不寫檔）
	python3 scripts/sync-codex-skills.py --check
	python3 scripts/sync-codex-prompts.py --check

test: ## 跑 tools 的單元測試（unittest，零依賴）
	python3 tests/test_financial_rigor.py
	python3 tests/test_report_audit.py

push: ## 推送 main 到 origin
	git push origin main
