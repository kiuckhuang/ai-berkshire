# Physical AI 應用層公司篩選總表

- **報告日期**：2026-09-24（以 `date` 指令確認）
- **數據截止日**：美股價格/統計 = 2026-09-23 收市（Yahoo Finance + stockanalysis.com 兩個獨立來源）；亞洲市場 = 2026-09-24 時段
- **研究性質**：學習研究用途，**唔構成投資建議**
- **數據信心標註**：PE/市值/利潤率 = 高信心（兩來源交叉）；營運數據（Waymo 週單、Symbotic backlog）= 中信心（新聞/公司發布，未經審計文件核實）；上交所公司（Roborock）PE = 未抓取留空；日本 Keyence 已核實（stockanalysis TYO:6861）
- **審計狀態**：已通過 `tools/report_audit.py` 抽檢流程（38 個數據點抽 6 個；ISRG 裝機量初版有誤已修正，修正後 6/6 通過）

## 研究背景（一句話）

本篩選係「AI 應用層」研究系列嘅 Physical AI 部分：辨識**用 AI tokens 驅動實體資產**（機械人/自駕/醫療器械/物流）嚟改善生產力同生活質素嘅公司，並按「賺錢現金流 → 啱啱轉賺 → 高增長燒錢 → 鏟仔供應鏈 → 分發平台」分層。

## 核心發現

1. **賺錢嘅全部係「舊硬件 + AI 大腦」**（ISRG 淨利率 28.5%、Keyence 35–40%、Deere 10.2%）——應用層 + 分發先贏，同 bandwidth 年代結構一致
2. **純 physical AI 新貴十居其九燒錢**（Tempus FCF -$263M、Waymo $126B 估值 ≈ 350x PS）
3. **結構性受惠者**：呢批公司嘅 COGS 入面 AI 成本會隨 token 價格下跌（5年-1,200倍）自動收縮——單價跌 → 機械人 vs 人工經濟學翻轉 → 毛利自動擴闊
4. **警號**：Alphabet Forward PE (25.2) > Trailing PE (17.0) = 分析員預期盈利倒退；Symbotic Trailing PE 3,218（無意義，剛轉賺）；Figure 估值 $39B 喺公司文件面前部署數字站唔住

## 三層篩選清單

### Tier 1｜賺錢現金流（核心倉「收息型」）

| 公司 | Ticker | Physical AI 用途 | 淨利率 | Trailing PE | Forward PE | 52週 |
|---|---|---|---|---|---|---|
| Intuitive Surgical | ISRG | da Vinci 手術機械人（裝機 11,710 台 @2026-06-30，+12%；80%+經常性收入）| 28.5% | 45.7 | 35.3 | -10.4% |
| Deere & Company | DE | 自主拖拉機 + See&Spray（農藥-60%）| 10.2% | 39.4 | 33.8 | +51.3% |
| Keyence | 6861.T | 機器視覺（工廠之眼）| 39.2% | 37.7 | 33.4 | +38.0% |
| Hesai | HSAI | LiDAR（出貨量第一；淨現金 $875M = 市值 34%）| 14.9% | 34.7 | 22.2 | -45.1% |
| Stryker / Medtronic | SYK / MDT | Mako / Hugo 手術機械人 | 賺錢 | 未抓取 | 未抓取 | — |
| Zebra | ZBRA | 倉庫機器視覺 | 賺錢 | 未抓取 | 未抓取 | — |
| Roborock | 688169.SS | 掃地機械人（家用已成功案例）| 賺錢 | 未抓取 | 未抓取 | — |
| FANUC / Yaskawa | 6954.T / 6506.T | 工業機械人/伺服 | 賺錢（週期）| 未抓取 | 未抓取 | — |

### Tier 2｜啱啱轉賺（賠率型）

| 公司 | Ticker | 用途 | 狀態 | Forward PE | 監察 |
|---|---|---|---|---|---|
| Symbotic | SYM | AI 倉庫機械人（Walmart）| FY26Q1 首次盈利 $13M；FCF $795M（含客戶預付）；backlog $22.5B | 63.9 | backlog 轉化率 + 毛利（現 21%）|
| Ouster | OUST | 數位 LiDAR | 接近打和 | — | 同 HSAI 對照 |

### Tier 3｜高增長燒錢（前景型，未有利潤）

| 公司 | Ticker | 用途 | 狀態 |
|---|---|---|---|
| Tempus AI | TEM | 精準醫療 AI/診斷（FDA xT CDx + BioNTech 夥伴）| TTM 蝕 $254M；短倉 16.3% 流通股 |
| Aurora | AUR | L4 自動卡車（Dallas–Houston）| 商業化啱啱起步 |
| Serve Robotics | SERV | 行人路送貨（Uber Eats）| 細市值高波動 |
| Butterfly | BFLY | 掌上超聲波 + AI 訂閱 | 醫療普及化故事 |

### 鏟仔供應鏈（唔使賭邊個客贏，但要賭 capex 週期）

- **NVIDIA**（Isaac/GR00T/Thor）：$225.51；$500B backlog 係訂單唔係收入
- **Qualcomm**：邊緣 AI 芯片；$197.24

### 分發/母公司（間接持倉入口）

- **Alphabet**（GOOGL，$4.13T 市值）：Waymo + TPU + Workspace；⚠️ Fwd PE > Trailing PE
- **Uber**（UBER，$69.42）：Waymo/Aurora 嘅分發入口

### 私人市場（買唔到，列作標尺）

- Waymo：$126B 估值 ≈ 350x PS；40–50 萬付費週單、重傷-92%；**但 44% 空駛**
- Figure（$39B）/1X/Zipline/Physical Intelligence

## 監察清單（觸發訊號）

| 指標 | 而家 | 觸發 |
|---|---|---|
| Waymo 週單 | 40–50 萬 | 100 萬（目標）/ 71 萬（獨立預測中位數）|
| Waymo 空駛率 | 44% | <30% |
| Symbotic 毛利 | 21% | >15%＋backlog 加速轉化 |
| Tempus FCF | -$263M | 轉正 |
| Token 價 vs 用量 | 單價-1,200倍 vs 用量爆升 | 用量增長% > 單價跌幅% → Jevons 贏 |
| 30 年期美債 | ~5.40% | 穿 6%（8% 概率 2026 底前 / 10–15% 2027）|
| HY 數據中心債息差 | 6 月起走闊 | >600bps → 路徑B引信 |

## 完整數據

- Excel（可排序 + 超連結）：`data/physical_ai_stocks_20260924.xlsx`
- CSV：`data/physical_ai_masterlist_20260924.csv`

## 來源

1. Yahoo Finance spark API（價格，2026-09-23/24）
2. stockanalysis.com 統計頁（PE/Forward PE/市值/利潤率，2026-09-23）
3. Reuters（2026-07-29 hyperscaler 發債）、Penn Mutual AM（2026-08-06 AI 債息差）、Fed SEP（2026-09-16）、Polymarket（債息概率）

> 低信心標註：Waymo/Symbotic 營運數據未經審計文件核實；日本/上交所估值指標未抓取；「6厘概率」屬預測市場定價，隨時變。
