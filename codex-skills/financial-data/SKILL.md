---
name: financial-data
description: "AI Berkshire skill: 財務數據獲取與交叉驗證規範. Source: skills/financial-data.md."
---

## Codex adapter note

This skill is generated from `skills/financial-data.md` so Claude Code and Codex users share one canonical workflow.

- Treat `$ARGUMENTS` as the user's request in the current Codex thread.
- When the source mentions Claude-only surfaces such as Task, Agent, WebSearch, Bash, Read, or Write, use the closest Codex capability available in this session: subagents when available, web search when needed, shell commands for local tools, and normal file edits for workspace files.
- Use shared project tools from `tools/` in this repository. Prefer running commands from the repository root with paths like `python3 tools/financial_rigor.py ...`; if the current thread starts outside the repo, locate the actual checkout path first instead of assuming a fixed home-directory path.
- Before starting research, run the `date` command to confirm today's date; treat it as the baseline for "latest" data and state the data cutoff date in the report header. Never assume the current date from training data.
- Preserve the research quality rules from `AGENTS.md`: cross-check financial data, use exact arithmetic tools for valuation/math, and clearly label uncertainty and source gaps.

# 財務數據獲取與交叉驗證規範

本規範適用於所有涉及企業財務數據的研究。**每個關鍵數據必須來自兩個獨立來源，誤差>1%須標記。**

---

## 數據源優先級

### 美股（PDD、騰訊ADR、網易ADR等）

| 優先級 | 來源 | URL | 獲取方式 |
|--------|------|-----|---------|
| 1（主） | **macrotrends** | macrotrends.net/stocks/charts/{ticker} | 直接訪問，無需註冊 |
| 2（副） | **stockanalysis** | stockanalysis.com/stocks/{ticker}/financials | 直接訪問，無需註冊 |
| 原始一手 | SEC EDGAR | sec.gov/cgi-bin/browse-edgar | 10-K / 10-Q 原文 |

### 港股（騰訊0700、網易9999、美團3690等）

| 優先級 | 來源 | URL | 獲取方式 |
|--------|------|-----|---------|
| 1（主） | **aastocks** | aastocks.com/tc/stocks/analysis/company-fundamental | 直接訪問 |
| 2（副） | **macrotrends**（ADR代碼） | 騰訊用TCEHY，網易用NTES | 直接訪問 |
| 原始一手 | HKEX披露易 | hkexnews.hk | 年報PDF |

### A股（三七互娛、吉比特等）

| 優先級 | 來源 | URL | 獲取方式 |
|--------|------|-----|---------|
| 1（主） | **東方財富** | eastmoney.com → 搜股票代碼 → 財務報表 | 直接訪問 |
| 2（副） | **巨潮資訊** | cninfo.com.cn | 原始年報/季報PDF |

### 臺股（臺積電2330、聯發科2454、大立光3008等）

| 優先級 | 來源 | URL | 獲取方式 |
|--------|------|-----|---------|
| 1（主） | **FinMind API** | api.finmindtrade.com | `tools/twstock_data.py`（零依賴腳本，見下） |
| 2（副） | **Goodinfo臺灣股市資訊網** | goodinfo.tw/tw/StockDetail.asp?STOCK_ID={代碼} | 直接訪問 |
| 原始一手 | 公開資訊觀測站（MOPS） | mops.twse.com.tw | 財報原文/月營收公告 |

**FinMind 取數工具**（分析臺股時優先調用，輸出自帶市值驗算）：

```bash
python3 tools/twstock_data.py quote 2330        # 最新行情 + PER/PBR/殖利率 + 市值驗算
python3 tools/twstock_data.py valuation 2330    # 估值指標 + PER一年區間 + 52周高低
python3 tools/twstock_data.py financials 2330   # 近5年年度核心財務（營收/毛利率/歸母淨利/EPS/ROE）
python3 tools/twstock_data.py revenue 2330      # 近13個月月營收及同比
python3 tools/twstock_data.py dividend 2330     # 近年股利政策（現金/股票股利、除息日）
python3 tools/twstock_data.py search 臺積        # 搜索股票代碼（注意臺股名稱爲繁體）
```

臺股特別注意：

1. **貨幣單位是新臺幣（TWD）**，與港幣/人民幣/美元混排時必須顯式標註，跨市場對比先統一換算
2. **月營收是臺股獨有優勢**：上市櫃公司每月10日前強制披露上月營收，是跟蹤基本面拐點最快的公開信號，earnings-review/thesis-tracker 類分析應優先利用（`revenue` 子命令）
3. FinMind 損益表爲**單季值**，工具已自動加總爲年度值；不足4季的年份會標註"僅前N季累計"
4. FinMind 未註冊可直接用（有小時級限額）。註冊後的 API token **只存本機、嚴禁提交到 git**，工具按優先級自動讀取：①環境變量 `FINMIND_TOKEN`；②本地文件 `local/finmind_token.txt`（`local/` 已被 `.gitignore` 永久排除，把 token 單獨一行寫入該文件即可）。token 不得出現在報告、skill、commit 中
5. 交叉驗證：FinMind 數值與 Goodinfo（或 macrotrends 上的 ADR，如 TSM）對照，誤差規則同下；臺積電等有 ADR 的公司注意 ADR 與臺股原股的匯率/存託比率差異（1 TSM ADR = 5 股 2330）

---

## 執行規範

### 第一步：獲取數據

對每個財務指標（收入、淨利潤、毛利率、經營現金流、資產負債率等），分別從**來源1**和**來源2**取數。

### 第二步：誤差計算與標記

```
誤差率 = |來源1數值 - 來源2數值| / 來源1數值 × 100%
```

| 誤差 | 處理方式 |
|------|---------|
| ≤ 1% | ✅ 一致，取來源1數值，標註兩個來源 |
| 1% ~ 5% | ⚠️ 標記"數據存在差異"，註明兩個數值，說明可能原因（匯率/會計口徑） |
| > 5% | ❌ 標記"數據存在重大差異"，必須查原始財報覈實，不得直接使用 |

### 第三步：數據呈現格式

每個關鍵數據必須按以下格式標註：

```
收入：1,239億元 ✅
  - macrotrends: 1,241億元
  - stockanalysis: 1,237億元
  - 誤差: 0.3%
```

差異示例：
```
淨利潤：245億元 ⚠️ 數據存在差異
  - macrotrends: 245億元（GAAP）
  - stockanalysis: 278億元（Non-GAAP）
  - 誤差: 13.5% — 原因：會計口徑不同（GAAP vs Non-GAAP）
```

---

## 常見差異原因（不一定是數據錯誤）

| 原因 | 說明 |
|------|------|
| GAAP vs Non-GAAP | 最常見，尤其是利潤類數據 |
| 匯率換算 | 港幣/人民幣/美元換算時間點不同 |
| 財年定義 | 自然年 vs 財年（如蘋果財年10月結束） |
| 合併口徑 | 是否含少數股東權益 |
| 數據更新滯後 | 某平臺尚未更新最新一期財報 |

---

## 特別規則

1. **未上市公司**（米哈遊、莉莉絲等）：只有一手數據來源時，數據前標記 `[估計]`，不執行交叉驗證
2. **季度數據 vs 年度數據**：優先使用年度數據做交叉驗證，季度數據部分來源可能有滯後
3. **原始財報優先**：若兩個來源均與原始財報（10-K/年報PDF）不符，以原始財報爲準，標記來源錯誤

---

## 股價與復權（歷史序列必讀）

價格有三種口徑，混用會讓歷史股價位置、長期漲幅、歷史估值分位全部失真：

| 口徑 | 含義 | 用途 |
|------|------|------|
| 不復權 | 實際成交價，除權除息日跳空 | 僅用於"當前時點"快照 |
| 前復權 | 以最新價爲基準回調歷史價 | 歷史股價對比、N年漲幅、歷史PE band 一律用它 |
| 後復權 | 以上市首日爲基準前推 | 計算歷史總回報/年化收益 |

規則：

1. 涉及歷史價格的分析統一用**前復權**，且同一分析內**不得混用**復權與不復權來源。
2. 當前市值/當前PE 用**當前實際股價 × 當前總股本**即可，與復權無關——復權隻影響歷史序列。
3. 跨越拆股/大比例送轉的每股指標（歷史EPS、歷史股價），必須復權還原後再同比。
4. 總回報/年化收益需計入分紅（後復權已含），只看價格漲幅會低估。
5. 增發/回購後市值驗算以最新總股本爲準（`financial_rigor.py verify-market-cap` 偏差>5% 會提示覈對）。

---

## 快速索引

| 場景 | 主要來源 | 備用來源 |
|------|---------|---------|
| PDD / 拼多多 | macrotrends.net/stocks/charts/PDD | stockanalysis.com/stocks/pdd |
| 騰訊 | macrotrends.net/stocks/charts/TCEHY | aastocks（0700.HK） |
| 網易 | macrotrends.net/stocks/charts/NTES | aastocks（9999.HK） |
| 三七互娛 | eastmoney.com（002555） | cninfo.com.cn |
| 吉比特 | eastmoney.com（603444） | cninfo.com.cn |
| Nintendo | macrotrends.net/stocks/charts/NTDOY | stockanalysis.com/stocks/ntdoy |
| Capcom | macrotrends（CCOEY） | stockanalysis（CCOEY） |
| 臺積電 | tools/twstock_data.py（2330） | goodinfo.tw / macrotrends（TSM，注意1 ADR=5股） |
| 聯發科 | tools/twstock_data.py（2454） | goodinfo.tw |
