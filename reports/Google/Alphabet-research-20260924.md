# Alphabet (GOOGL) 深度研究：Fwd PE > Trailing PE 之謎拆解

> **報告日期**：2026-09-24（以 `date` 指令確認）
> **數據截止**：美股價格/統計 = 2026-09-23 收市；基本面 = Q2 2026 財報（2026-07-22 發布）
> **系列定位**：Physical AI 應用層系列——「分發/母公司」層（間接揸 Waymo），對接 `筛选公司/PhysicalAI-應用層篩選-20260924.md`
> **性質**：學習研究用途，**唔構成投資建議**。所有「觀點/推測」已標註；估計值標「估計」；查唔到嘅標「未核實」
> **審計狀態**：已行 `tools/report_audit.py` 抽檢流程（結果見報告頭審計記錄）；市值/PE/核心 EPS 用 `tools/financial_rigor.py` 精確驗算
> **前作對話**：本報告係 `Google-Alphabet投资研究报告-20260623.md` 嘅三個月更新，第九節逐項對話

---

## 核心判斷（一段話）

GOOGL 表面「Trailing PE 17.0、Fwd PE 25.2」——市場共識預期未來 12 個月 EPS 倒退 ~33%。拆解結果：**呢個「倒退」八成以上係會計錯覺**——TTM 淨利 $244B 入面有 ~$116B（稅後）係 Anthropic/SpaceX 持股嘅一次性按市價重估收益，2027 年共識已將佢滾出基數；核心經營 EPS 共識其實係 **+24% 增長**。但訊號唔係廢——佢照出兩個真警號：**盈利質素被私有 AI 持倉污染**（Alphabet 變咗半隻 AI 私市基金 sidecar），同埋**資本周期逆轉**（capex $195-205B、FCF 轉負、回購歸零、改為發股+$90B 融資）。以核心口徑計，GOOGL 而家係 **32x 核心 PE、78x P/FCF**，唔係 17x——「$4T 公司 17 倍 PE 極平」係錯覺，但亦唔係價值陷阱；係一間用股東現金流換 AI 資產負債表嘅公司，等 10-28 業績驗證。

---

## 1. 研究定位：分發/母公司層——點解 GOOGL 係「間接揸 Waymo」嘅入口

喺 Physical AI 應用層篩選（22 標的）入面，GOOGL 同 UBER 歸入「分發/母公司」層：唔直接賣機械人，但揸住 Physical AI 最大資產嘅母公司權益同分發入口。GOOGL 嘅 Physical AI 曝險全貌：

| 曝險 | 載體 | 最新數據（來源，日期） | 變現路徑 |
|---|---|---|---|
| **Robotaxi** | Waymo（Alphabet 控股母公司） | $126B 估值、$16B 外部融資（2026-02，Bloomberg/GCBC）；~50 萬付費週單（2026-03-27 公佈，happycapyguide/eletric-vehicles）；目標 2026 年底 100 萬週單（co-CEO Mawakana，Bloomberg 2026-02-11）；12 城+London 擴張、Gen-6「Ojai」車隊（CNBC 2026-02-12）；Q1 2026 收入 $355M（axis-intelligence，**未審計**） | 分拆/引資定價重估；但 Other Bets 經營虧損 TTM -$8.9B（stockanalysis，2026-06 TTM）——燒錢繼續 |
| **機械人大腦** | Gemini Robotics 2（DeepMind，2026-07-30 發布） | 人形機械人全身控制 VLA 模型家族（DeepMind 官網；SiliconANGLE 2026-07-30） | 暫無獨立收入；授權給機械人 OEM 為潛在期權 |
| **算力外銷** | TPU 系統透過 Google Cloud 出售/出租 | Meta 簽多年、數十億美元 TPU 租用協議（2026-02-26/27，The Information 轉述：dataconomy/hirenest）；公司披露 TPU 系統銷售 Q2 2026 開始確認收入，大頭喺 2027（TipRanks Q2'26 業績摘要） | Cloud 收入 + 2027 起第二增長曲線 |
| **Physical AI 基建** | 資料中心/能源 | Georgia Power 核電擴容協議（Reuters 2026-09-21）；Kairos Power SMR 由 Samsung C&T 承建（TechCrunch 2026-09-21） | 支撐 AI 算力供給 |

**觀點**：GOOGL 唔係純 Physical AI 概念股——佢 90% 收入仍係廣告/訂閱/雲，Waymo 係入面一塊約 $100B 級（推算，未核實持股比例）嘅期權。買 GOOGL 唔等於買 Waymo；但喺公開市場，佢係唯一間接揸到全球最大 robotaxi 營運商嘅大市值入口。

> 段永平語錄：「買股票就是買公司，買公司就是買其未來現金流的折現。」——問題係：Google 嘅未來現金流，而家有幾多寫喺廣告合約度，幾多寫喺 Anthropic 嘅估值表度？

---

## 2. 關鍵數據概覽

| 指標 | 數值 | 來源（日期） |
|---|---|---|
| 股價 | **$337.83**（9-23 收市，-3.80%） | Yahoo chart API + stockanalysis（2026-09-23）|
| 市值 | **$4.13T**（驗算 337.83×12.23B=$4.13T，financial_rigor 偏差 0.04%） | stockanalysis + 手算驗證（2026-09-23）|
| 總股本 | 12.23B（6 月 $90B 融資後攤薄增加） | stockanalysis（2026-09-23）|
| 52 週區間 | $235.84–$408.61（現價距高位 -17.3%） | Yahoo（2026-09-23）|
| Trailing PE | **16.95**（TTM EPS $19.93） | stockanalysis 16.95；macrotrends 16.97（2026-09-23）|
| **Forward PE** | **25.24**（隱含 NTM EPS $13.38） | stockanalysis（2026-09-23）；用 Yahoo 共識推 NTM ≈24.9x 交叉 |
| FY2026E / FY2027E EPS | **$20.62（+90.8%）/ $14.90（-27.75%）** | Yahoo analysis（49 分析師，2026-09-23）+ stockanalysis forecast 一致 |
| FY2026E / FY2027E 收入 | $498.6B（+23.8%）/ $614.8B（+23.3%） | 同上 |
| Q2 2026 實績 | 收入 $119.8B（+24%）、經營利潤 $40.8B（+30%，34.0%）、淨利 $112.2B（+298%）、EPS $9.11 | 財報 8-K（2026-07-22）+ TipRanks + beancount |
| **Q2 一次性投資收益** | **$99.0B**（主要 Anthropic+SpaceX 重估；稅後 +$77.1B、+EPS $6.26） | 公司財報披露（2026-07-22）；Fortune（2026-07-22）|
| TTM 經營現金流 / capex / FCF | $185.7B / $132.4B / **$53.3B（-20.2%）** | stockanalysis TTM（2026-06-30 止）|
| 2026 capex 指引 | **$195-205B**（原 $180-190B，再上調） | abc.xyz 電話會（2026-07-22）+ TipRanks |
| 2027 capex |「significantly increase」（無量化） | 電話會（2026-07-22）|
| 現金+短投 / 長債 | $242.5B（含 $87.1B 股票投資）/ $98.2B | TipRanks 業績摘要（2026-07-22）|
| 股息 | $0.22/季（$0.88/年，息率 0.26%） | stockanalysis（2026-09-23）|
| 分析師共識 | Strong Buy（62 位分析師，S&P Global 口徑），平均目標價 $428.41（+26.8%）；MarketBeat 54 位口徑：Buy / $422.16 / 最低 $255 / 最高 $515 | stockanalysis（2026-09-23）+ MarketBeat（2026-09-23）|
| 下一業績 | **2026-10-27/28**（Q3'26 共識 EPS $3.02） | TipRanks 估 10-27；Yahoo 共識 |

---

## 3. 核心章節：Fwd PE 25.2 > Trailing PE 17.0 之謎拆解

### 3.1 第一步：確認訊號係真嘅（唔係抓取錯誤）

- stockanalysis.com（2026-09-23）：PE **16.95** / Forward PE **25.24**，同股價 $337.83 同頁顯示
- macrotrends（2026-09-23）：TTM EPS $19.91，PE **16.97**——獨立來源一致
- Yahoo analysis（2026-09-23）：FY2026 EPS 共識 $20.62、FY2027 **$14.90**（49 位分析師，區間 13.67–17.21），FY27 vs FY26 = **-27.75%**——兩個獨立數據商完全一致
- 用 stockanalysis 口徑驗算：25.24 × 隱含 NTM EPS = 337.83/25.24 = **$13.38**；Yahoo 共識 Q3'26E $3.02 + Q4'26E $3.35 + FY27 上半年推算 ~$7.0 ≈ $13.4——**數字閉合，訊號屬實**（來源：financial_rigor 計算）

### 3.2 第二步：數學上「倒退 33%」代表乜

| 口徑 | EPS | 對比 |
|---|---|---|
| TTM GAAP（含一次性收益） | $19.93 | 基準 |
| 隱含 NTM（Fwd PE 反推） | $13.38 | **-32.9%** vs GAAP TTM |
| TTM 核心經營（剔除稅後一次性收益 ~$116.1B÷12.25B 股 = $9.48） | **$10.45**（估計：稅率用公司披露嘅 22.1% 口徑） | **+28.0%** vs 隱含 NTM |
| 核心口徑 Trailing PE | **32.3x**（financial_rigor 驗算） | ≠ 表面 17.0x |

**結論（拆解）**：所謂「市場預期 EPS 倒退 33%」，其實係「市場拒絕將 $116B 紙面收益當經常性盈利」。共識隱含嘅核心經營 EPS 路徑係增長唔係倒退。

### 3.3 第三步：FY2026→FY2027 EPS 共識橋（$20.62 → $14.90，-$5.72）

| 項目 | 每股（美元） | 說明 |
|---|---|---|
| H1 2026 稅後一次性收益滾出基數（估計） | **-8.61** | 來源：Q1'26 投資收益稅前 $36.8B（stockanalysis 現金流表）+ Q2'26 稅後 $77.1B（財報披露）；以加權股數約 12.28B 攤分；稅率口徑 22.1%（財報 21.9/99.0） |
| 核心經營增長貢獻 | **+2.89** | Yahoo/stockanalysis 共識：FY27 $14.90 vs FY26 剔除收益後 $12.01，即 **+24.06%**（financial_rigor 驗算）——共識明明係增長 |
| **淨變化** | **-5.72** | 即共識「倒退 27.8%」 |

**逐項歸因結論**：共識 EPS「倒退」嘅構成 = **投資收益滾出（-150% 嘅貢獻，即全部倒退都有餘）+ 核心增長（+50% 對沖）**。AI capex 折舊、反壟斷、搜尋侵蝕**唔係**呢條橋嘅主項——佢哋已經被消化喺「+24.1% 核心增長」呢個數入面。

### 3.4 第四步：capex → 折舊海嘯幾時先刺到 EPS？

capex 實數/指引（兩來源以上）：FY2024 $52.5B → FY2025 **$91.45B**（Q4'25 $27.85B）→ 2026 指引 $175-185B（2026-02-04，Fortune）→ $180-190B（2026-04-29，S&P Global）→ **$195-205B**（2026-07-22 電話會；Q2 實數 $44.9B，+107%，60% 伺服器/40% 數據中心+網絡）→ 2027「significantly increase」（**估 $250B+，未核實**）。

| 敏感性：年折舊增加 | 稅後淨利影響（税率20%） | EPS 影響（12.3B 股） |
|---|---|---|
| +$10B/年 | -$8.0B | **-$0.65** |
| +$30B/年 | -$24.0B | -$1.95 |
| +$50B/年 | -$40.0B | -$3.25 |
| +$70B/年 | -$56.0B | -$4.55 |

（financial_rigor 計算。）

**路線圖（估計）**：D&A 已由 FY2023 $11.9B → FY2025 $21.1B → TTM $25.5B。若 2026-2028 累計 capex ~$730B（200+250+280），按 60% 伺服器 6 年/40% 基建 15 年直線法，穩態年折舊 ~**$92B**——比 FY2025 高 ~$71B，對應 2029-2030 年 EPS 頭風 ~$4.6（相當於共識 FY27 EPS 嘅 31%）。**但**：呢筆數唔係共識盲點——共識 FY27 收入 +23.3% 而核心 EPS +24%，營業槓桿已被折舊吃平（FY2025 EPS 增 32% vs 收入增 15% 嘅黃金比例已消失）。折舊海嘯真正風險係 2028+：如果 AI 收入增速放緩而折舊照衝，EPS 會出現共識未定價嘅二次探底。

### 3.5 第五步：其他候選歸因逐項過秤

| 候選歸因 | 共識入面佔幾重 | 證據 |
|---|---|---|
| a) AI capex→折舊 | 已內化於 +24% 核心增長；2028+ 係真風險 | 見 3.4 |
| b) 反壟斷 | **唔係**共識 EPS 倒退主因（Search 收入仍 +17%） | Mehta 2025-09-02 裁決：唔拆 Chrome、禁排他默認協議、強制數據授權；2025-12 終審生效、2026-02-03 落地（LitigationLogic 2026-05-22）；Google 1 月上訴（數據授權條款）、DOJ 2026-02-03 交叉上訴（仍求拆 Chrome+終止 Apple 默認協議）；DC Circuit 未定口頭辯論期，拉到 2027——**係尾部風險，唔係共識基線** |
| c) 搜尋市佔被 AI chat 侵蝕 | 暫無實質收入侵蝕證據 | Google 傳統搜尋市佔 ~89.3-90.4%（StatCounter 轉述，2026-05/06）；ChatGPT 佔 AI chatbot 份額 64.5-79%（stackmatix/perplexityaimagazine，2026-03/05）；但 Q2'26 Search 收入 +16.8% 加速——「侵蝕」暫時只係敘事 |
| d) 其他（罰款/TAC/Waymo） | 邊際 | EU 位置數據罰款 $463M（NY Post 2026-09-21）≈ 一日利潤；Waymo 虧損已喺 Other Bets OI -$8.9B TTM 內 |

### 3.6 反方論據：市場可能啱定錯？

**市場可能啱（警號派）**：
1. TTM 淨利 47% 係紙上收益——Anthropic $350B、SpaceX 等私有估值由同樣喺吹 AI 泡泡嘅一級市場定價；呢啲 marks 可以反向走（回撥直接打爆 GAAP EPS）。Alphabet 實質將自己變成「AI 一級市場基金 sidecar」。
2. Q2'26 FCF **-$5.9B**、TTM FCF $53.3B（-20.2%）、回購 $17.4B TTM（Q2 歸零）+ 發 $90B 股——現金流先係真相，EPS 係化妝。
3. 折舊海嘯 2028-2029 至批量到岸（見 3.4 路線圖），共識 2027 可能仍高估。

**市場可能錯（錯價派）**：
1. 核心口徑 25.2x Fwd vs 32.3x 核心 trailing——市場其實係畀緊**更平**嘅遠期核心盈利倍數，方向同「警號」解讀相反。
2. 收入 +24% 加速、Cloud +82% 而邊際利潤 35.6%、backlog $514B（>50% 兩年內確認）——呢啲係審計過嘅收入唔係 marks。
3. TPU 外銷（Meta 租約）+ Gemini Enterprise（90% Fortune 100）+ Waymo 50 萬週單——三條期權都未喺共識 EPS 度充分定價。
4. Berkshire Hathaway 6 月私人配售 $10B——歷史上最挑剔嘅資本喺 $4T+ 市值位買入（Cleary Gottlieb 2026-06-04；publicnow 2026-06-01）。

> 巴菲特語錄：「會計是商業的語言，但你要小心，有些人講嘅係方言。」——$99B gain 係 GAAP 語言，唔係現金流語言。

---

## 4. 生意本質（段永平視角）：搜尋現金牛 vs AI 投入期

**事實層**：Google Services Q2'26 收入 $94.5B（+14.5%）、經營利潤 TTM $153.8B；毛利率 61.6%（歷史新高）、經營利潤率 34.0%——現金牛唔單止未死，重加速。雲由 FY2024 $43.2B → FY2025 $58.7B → TTM $77.6B，雲經營利潤 $6.1B → $13.9B → TTM $24.3B（stockanalysis metrics）。

**但生意嘅資本結構已質變**：

| 年度 | 收入 | capex | capex/收入 | 經營現金流 | FCF |
|---|---|---|---|---|---|
| FY2021 | $257.6B | $24.6B | 9.6% | $91.7B | $67.0B |
| FY2023 | $307.4B | $32.3B | 10.5% | $101.7B | $69.5B |
| FY2024 | $350.0B | $52.5B | 15.0% | $125.3B | $72.8B |
| FY2025 | $402.8B | $91.4B | 22.7% | $164.7B | $73.3B |
| TTM（至 2026-06） | $445.9B | $132.4B | 29.7% | $185.7B | $53.3B |
| FY2026E | $498.6E | $195-205E | **~40%** | — | Q2 已轉負 |

（來源：stockanalysis 各期；2026 為指引。）

**觀點（段永平追問：生意質素有冇變？）**：變咗一半。廣告呢部「印鈔機」仲係極好生意（定價權、網絡效應、+17% 增長），但公司整體由「輕資產收租」變成「重資產製造+一級市場投資」混合體。好生意唔應該要每年投入 1.4 倍淨利潤做 capex——除非佢信 AI 回報率 > 資本成本。喺 10Y >5.1%、hyperscaler 30 年債實際成本 ~6.5%（HANDOVER 交接文件引 Goldman/Penn Mutual，2026-08/09）嘅貼現率環境，呢個赌注嘅門檻回報大幅提高。管理層用行動投票（capex 四度上調），但股東要用 FCF 收益率 1.3%（$4.13T/$53.3B）買呢個信念。

---

## 5. 財務與估值（巴菲特視角）

### 5.1 分部趨勢（FY2024→FY2025→TTM 2026-06，stockanalysis metrics）

| 分部 | FY2024 | FY2025 | TTM | 經營利潤 TTM |
|---|---|---|---|---|
| Search & Other | $198.1B | $224.5B | $243.3B | Google Services OI $153.8B |
| YouTube 廣告 | $36.2B | $40.4B | $42.6B | （併入 Services）|
| Network | $30.4B | $29.8B | $29.5B | 持續萎縮 |
| 訂閱/平台/設備 | $40.3B | $48.0B | $51.7B | |
| **Cloud** | $43.2B | $58.7B（+35.8%）| **$77.6B** | **$24.3B**（利潤率 ~31%）|
| Other Bets | $1.65B | $1.54B | $1.51B | **-$8.9B** |

### 5.2 capex vs OCF 缺口（對接篩選報告宏觀帳）

五大廠 2026 capex ~$700-750B vs OCF ~$778B（篩選報告引 HANDOVER）——Alphabet 一家就佔缺口擴大嘅主因之一：2026E capex $200B（中位）vs OCF run-rate ~$190-200B，**單季 FCF 已轉負（Q2'26 -$5.9B）**。融資對策已全部上場：$25B 債（TNW，超額認購 $115B）、¥576.5B 日債（2026-05）、18 個月發債 >$85B/6 種貨幣（Cleary）、然後係**歷史性轉向——發股**：

| 2026-06 融資包（Cleary Gottlieb 2026-06-04） | 金額 |
|---|---|
| 承銷普通股（A+C） | $20.7B |
| 強制可轉換優先股（兩系列，6.25% 票息，含 capped call） | $19.3B（Loop Capital 聯席帳簿管理人公告同數） |
| ATM 計劃（2026-06-01 啟動，Q3 起用） | $40B |
| **Berkshire Hathaway 私人配售** | **$10B** |
| 合計（含超額配售） | **$90B** |

**事實**：Q2'26 回購 $0（beancount 引 10-Q），TTM 回購 $17.4B vs FY2024 $62.2B——「S&P 500 最可靠回購機器」停機，股東回報讓位俾 AI capex。**觀點**：喺 $4.5T 市值高位發股而不是發債，管理層係話俾你聽「連佢哋都覺得而家嘅資本開支負擔唔起 6.5% 嘅債息」——呢個判斷本身有信息量。

### 5.3 估值對照表

| 口徑 | 數值 | 判讀 |
|---|---|---|
| GAAP Trailing PE | 17.0x | **虛低**（47% 盈利係一次性 marks） |
| 核心 Trailing PE | **32.3x**（financial_rigor） | 真實起點 |
| Forward PE（NTM） | 25.2x | 對應核心 EPS +24-28% 增長 |
| P/FCF（TTM） | **77.5x** | 巴菲特最計較嘅數——貴 |
| EV/S（TTM） | ~8.9x（EV≈$3.99T） | 歷史高位區；對照 2025-06-30 收市 $175.62（macrotrends + Yahoo adjclose 雙源）時約一半水平 |
| 股息 | 0.26% | 象徵式 |
| 對比 6-23 報告 | 當時 TTM PE ~28x @ $349.68 | **同樣價位，PE「跌」至 17x 全因 marks 入帳**——倍數幻覺教科書案例 |

---

## 6. 行業與競爭（芒格視角）

**正面論據**：
1. **搜尋未死且加速**：Q2'26 Search & Other +16.8%（Q1 +19%），AI Mode 破 10 億月活、Gemini App 9.5 億月活（DAU 按年×3）——AI 概覽/AI Mode 擴大查詢量而唔係替代變現（公司電話會 + beancount 分析）。
2. **雲第三極成形**：+82% 加速、35.6% 邊際利潤、backlog $514B——供不應求，要用第三方算力過橋（TipRanks 業績摘要）。
3. **TPU 外銷破冰**：Meta 數十億美元租用協議（2026-02-26，The Information 轉述）——直接挑戰 NVDA 垄断嘅第一單大客；TPU 系統銷售收入確認大頭喺 2027（公司披露）。**觀點**：若 Meta/Microsoft 級客戶持續改用 TPU，NVDA 嘅 70%+ 毛利定價權將首次遇到量級對手；但而家只係一單租約，唔好將傳聞當趨勢。
4. **全棧獨一家**：芯片（TPU）→模型（Gemini 4 預訓練中）→應用（Search/YouTube/Workspace）→Physical AI（Waymo/Gemini Robotics 2）。

**反面論據**：
1. Meta「Muse AI」助手擴張，2026-09-23 GOOGL 單日 -3.8%（Invezz 2026-09-23）——競爭敘事隨時再殺估值。
2. 搜尋等效流量入面 AI 份額上升（AI 會話 45B/月，2026-03，stackmatix）——收入未跌唔等於結構未變；YouTube 亦被 Netflix 搶人才（WSJ 2026-09-23）。
3. 雲份額（~12-14%）仍落後 AWS/Azure；供應受限期要用第三方算力（毛利橋壓）。
4. 監管多線作戰：DOJ 上訴、EU $463M 罰款、UK CMA 9-23 提議 Android/Chrome 搜尋選擇權（Reuters 2026-09-23）。

> 芒格語錄：「反過來想，總是反過來想。」——反過來問：乜嘢情況下 Google 贏咗 AI 競賽但輸咗搜尋經濟學？答案仲未出現喺數據度，但佢出現嘅價位（-3.8% 一日）比三個月前平咗。

---

## 7. 風險與管理層（李錄視角）

### 7.1 反壟斷結局情景（基於 LitigationLogic 2026-05-22 + winbuzzer 2026-02-05）

| 情景 | 內容 | 對 EPS 影響（估計） | 概率（觀點） |
|---|---|---|---|
| 維持原判（行為補救） | 數據授權+禁排他生效，Chrome 保留 | Apple 默認協議照舊、TAC 變動有限；年收入影響 <1% | 55% |
| DOJ 上訴得直（結構補救） | Chrome 剝離或 Apple 默認協議終止 | 參考 6-23 報告：$150-250 億/年收入風險，對 EPS -5-9% | 25% |
| 數據授權加碼 | 競品（含 OpenAI）獲索引級數據 | 慢性侵蝕，3-5 年顯現 | 20% |

時點：DC Circuit 未定口頭辯論，判決大概率 2027 年——**2026 年入帳嘅不確定性主要係估值折讓，唔係 EPS**。

### 7.2 管理層執行紀錄（Pichai/Ashkenazi）

| 決策 | 結果 | 評分 |
|---|---|---|
| 2026 capex 指引四連跳（$175B→$205B）但每次都畀 Cloud +82% 數據背書 | 供應受限係真嘅（backlog $514B） | ★★★★ |
| 6 月 $90B 股權融資（高位發股+優先股+Berkshire 背書） | 資本成本管理聰明，但股東攤薄 1.7%+（drillr 2026-06） | ★★★☆ |
| Q2 回購歸零 | 股東回報讓位，通訊上未充分解釋 | ★★★ |
| Wiz（~$32B，Q2'26 入帳 goodwill +$24.5B）+ Intersect Power 收購 | 雲安全+能源縱向整合，未證明回報 | 待觀察 |

### 7.3 Waymo 燒錢幾耐（李錄最關心：能力圈+誠實面對未知）

- 事實：Other Bets 經營虧損 TTM -$8.9B（FY2024 -$4.4B——**虧損擴大一倍**）；Waymo Q1'26 收入 $355M（未審計）vs $126B 估值 ≈ 350x PS（篩選報告口徑）。
- 事實：空駛率（deadheading）44%（axis-intelligence，**未審計**）；重傷率 -92% 安全數據正面。
- **觀點**：以 2026 年底 100 萬週單目標計，若單均收入 ~$20，年收入僅 ~$1B 級——Waymo 由「實驗」轉「業務」，但距離養起自己仲有 3-5 年。母公司補貼能力無虞（現金 $242B），問題係 2030 年前呢塊資產喺財報上只會係負數線。

---

## 8. 情景分析（financial_rigor three-scenario，基數 = 共識 FY2027 EPS $14.90）

| 情景 | EPS CAGR（3年） | 目標 PE | 目標 EPS | 目標價 | 潛在回報 | 關鍵假設 |
|---|---|---|---|---|---|---|
| 牛市 | +20% | 24x | $25.75 | **$617.9** | +82.9% | TPU 外銷放量、雲維持 50%+、Waymo 2027 年 100 萬週單後獨立融資重估、折舊被收入稀釋 |
| 基準 | +12% | 20x | $20.93 | **$418.7** | +23.9% | 收入 +20-23%、折舊拖累被抵消、反壟斷維持行為補救、一次性收益歸零 |
| 熊市 | -2% | 15x | $14.02 | **$210.4** | -37.7% | AI 私市估值回撥（marks 反向）+雲減速至 30%+折舊海嘯疊加+DOJ 上訴得直 |

（工具輸出可復現；10Y 5.1% 環境下基準 20x 係假設增長可信，熊市 15x 對應 2007 年後新高貼現率。）

### 觸發訊號儀表板

| 訊號 | 而家 | 觸發動作 |
|---|---|---|
| **2026-10-27/28 Q3 業績** | 共識 EPS $3.02 | 睇：①2027 capex 首次量化 ②折舊指引 ③雲 Q3 第三方過橋毛利影響 ④Search 增速能否守 15%+ ⑤TPU 外銷確認節奏——**呢份業績直接裁決 Fwd>Trailing 之謎嘅「capex 擠壓」成分** |
| Waymo 週單 | ~50 萬 | 100 萬（公司目標，2026 底）/ 71 萬（獨立中位）→ 母公司期權重估 |
| 30Y 美債 | ~5.4% | 收市穿 6% → 路徑 B（事故）權重上調，高 capex 估值全線承壓 |
| Anthropic/SpaceX 私市輪次 | $350B（2026-04） | 再上調→marks 續入帳；下調→GAAP EPS 回撥風險 |
| TPU 外銷 | Meta 一單 | Microsoft/其他官宣 → 第二曲線定價 |
| HY 數據中心債差 | **418bps**（2026-08 現值，HY HPC 口徑，走闊中；監察閾值 600bps） | 穿閾 → AI capex 融資斷層警報 |

---

## 9. 與 2026-06-23 報告對話：三個月後要更新嘅判斷

| 舊判斷（2026-06-23） | 現況（2026-09-24） | 更新 |
|---|---|---|
| 「TTM PE ~28x、Fwd 29.4x，不貴不便宜」 | 價位相若（$349.68→$337.83）但 GAAP PE 跌到 17x / 核心 32x | **更新**：舊報告嘅「PE 略高於歷史均值」框架已失效——而家要拆 GAAP vs 核心，倍數幻覺係本季最重要嘅課 |
| capex 指引 $180-190B（視為約淨利 1.4 倍） | 指引 $195-205B + 2027「顯著增加」；Q2 FCF 轉負 | **加碼確認**：舊報告嘅「隱憂」已兌現成 FCF 轉負+回購歸零 |
| 「合理價 $280-350，<$280 有吸引力」 | 3 月曾見 $287.20；而家 $337.83 | **部分失效**：嗰個定價框架用真 EPS；而家 GAAP EPS 含 marks，<$280 嘅「安全邊際」要重新用核心 EPS 驗算（對應核心 PE <23x） |
| 反壟斷「Chrome 保住了，判決溫和落地」 | 補救 2026-02-03 生效，但 DOJ 交叉上訴重求拆 Chrome | **更新**：判決未完，2027 年 DC Circuit 判決係下一個事件風險 |
| 雲增速（季同比） | **82%** | 由上一季 63% 加速；backlog $514B | **加碼正面**：雲由「防禦」變「第二利潤支柱」 |
| Meta 廣告收入 2026 超越 Google（60% 概率） | Meta Muse AI 助手攻勢，9-23 拖低 GOOGL | **維持**：相對統治力下降係趨勢 |
| 空倉者觀望至 $280-300 | 現價 $337.83、核心 PE 32.3x | **維持觀望**，但買入區需下修至核心口徑 $260-290（NTM EPS $13.4×19-21.5x，觀點） |

---

## 10. 結論

### 評分

| 維度 | 評分 | 一句話 |
|---|---|---|
| 生意質素（段永平） | ★★★★ | 廣告印鈔機完好（+17%），但公司整體資本密度質變（capex/收入 10%→40%） |
| 護城河（巴菲特） | ★★★★ | 搜尋+YouTube+Android+TPU 全棧仍寬，但入口形態喺 AI 時代重定價中 |
| 財務強度（巴菲特） | ★★★ | 淨現金變薄、FCF -20%、回購歸零——強度仍在，方向轉差 |
| 管理層（李錄） | ★★★★ | capex 紀律有數據背書；高位發股+優先股係聰明但股東回報讓位 |
| **估值吸引力** | ★★★ | 核心 32.3x/P-FCF 78x 唔平；25x Fwd 配 +24% 核心增長唔算貴；貼現率 5%+ 壓制倍數 |
| **綜合** | **★★★★** | 條件性正面：呢個價位買嘅係「AI 基建龍頭+分發權」，唔係 17x 嘅平貨 |

### Fwd>Trailing：警號定錯價？

**本報告判斷（觀點）**：**主要係錯價/會計錯覺，次要係真警號**。

1. 共識「-33% EPS 倒退」嘅 -150% 來自一次性投資收益滾出（-$8.61），核心經營共識係 +24% 增長（+$2.89）——所以「AI capex 擠壓導致盈利倒退」呢個直覺解讀**唔成立於共識數據**。
2. 但佢係**盈利質素警號**：TTM 淨利 47% 唔係現金；Anthropic/SpaceX marks 令 Alphabet 報表同 AI 一級市場估值同生共死。若 AI 私市降溫，17x 嘅「平」會即刻變貴。
3. 佢亦係**資本周期警號**：capex/收入 40%、FCF 轉負、回購歸零、發股 $90B——喺 10Y >5.1% 環境，呢套組合嘅容錯率遠低於 2024-25。

**前提條件（判斷成立需要）**：① 10-28 業績證明 Search +15%/雲 50%+ 增速可持續；② 2027 capex 量化後折舊曲線被收入增長稀釋；③ DC Circuit 維持行為補救；④ Waymo 週單 2026 年底逼近 70-100 萬。任一反轉，評分降至 ★★★。

**操作含義（唔構成建議）**：現價觀望/持有；核心口徑買入區 $260-290（觀點）；$408 高位唔追。倉位思考：GOOGL 喺 Physical AI 組合入面嘅角色係「分發入口+期權組合」，唔係 Tier 1 現金流股。

> 李錄語錄：「真嘅安全邊際來自對生意嘅理解，而唔係市場報價。」——17x 係報價，32x 先係生意。

---

## 11. 來源清單

| # | 來源 | URL | 取用日期 |
|---|---|---|---|
| 1 | Yahoo Finance chart API（GOOGL 價格/52週） | https://query1.finance.yahoo.com/v8/finance/chart/GOOGL?range=5d&interval=1d | 2026-09-24 |
| 2 | stockanalysis.com GOOGL 概覽/預測/財務/資產負債/現金流/指標 | https://stockanalysis.com/stocks/googl/（+ /forecast/ /financials/?p=quarterly /financials/cash-flow-statement/?p=ttm /financials/balance-sheet/?p=quarterly /financials/metrics/） | 2026-09-24 |
| 3 | Yahoo Finance GOOG analysis（EPS 共識 FY26/27） | https://finance.yahoo.com/quote/GOOG/analysis/ | 2026-09-24 |
| 4 | Macrotrends GOOGL PE Ratio（TTM EPS 歷史） | https://www.macrotrends.net/stocks/charts/GOOGL/alphabet/pe-ratio | 2026-09-24 |
| 5 | MarketBeat GOOGL Forecast（評級/目標價） | https://www.marketbeat.com/stocks/NASDAQ/GOOGL/price-target/ | 2026-09-24 |
| 6 | Alphabet Q2 2026 電話會逐字稿（abc.xyz IR） | https://abc.xyz/investor/events/event-details/2026/2026-Q2-Earnings-Call-2026-GgTAq7Is0z/default.aspx | 2026-09-24 |
| 7 | TipRanks GOOGL Q2 2026 Report（實績 vs 共識、指引、資產負債口徑） | https://www.tipranks.com/stocks/googl/earnings/q2-2026-report | 2026-09-24 |
| 8 | beancount.io Q2 2026 10-Q 分析（分部/一次性收益/回購歸零） | https://beancount.io/blog/2026/07/21/alphabet-q2-2026-earnings-analysis | 2026-09-24 |
| 9 | BigGo Finance Q2'26 電話會整理（雲利潤率/FCF/capex） | https://finance.biggo.com/news/US_GOOGL_2026-07-22 | 2026-09-24 |
| 10 | Fortune：Anthropic/SpaceX 利潤季度（2026-07-22） | https://fortune.com/2026/07/22/anthropic-spacex-investments-google-earnings-biggest-ever-profit-quarter/ | 2026-09-24 |
| 11 | Cleary Gottlieb：$90B 股權融資法律公告（2026-06-04） | https://www.clearygottlieb.com/news-and-insights/news-listing/alphabet-in-80-billion-equity-offerings-jun-2026 | 2026-09-24 |
| 12 | publicnow：$80B 融資+Berkshire $10B 配售（2026-06-01） | https://www.publicnow.com/view/D33B966021FD03D0F99B3A1D8346A1D71C866B44 | 2026-09-24 |
| 13 | TNW：Alphabet $25B 發債 | https://thenextweb.com/news/alphabet-25-billion-bond-sale-ai-capex-twice-yearly | 2026-09-24 |
| 14 | Fortune：2026 capex 首次指引 $175-185B（2026-02-04） | https://fortune.com/2026/02/04/alphabet-google-ai-spending-supply-constraints/ | 2026-09-24 |
| 15 | S&P Global MI：Q1'26 指引上調 $180-190B（2026-05） | https://www.spglobal.com/market-intelligence/en/news-insights/research/2026/05/alphabet-postq-snapshot-ai-momentum-drives-cloud-surge-capex-outlook-rises1 | 2026-09-24 |
| 16 | mlq.ai/gate.com：Q2'26 指引上調 $195-205B | https://mlq.ai/news/alphabet-raises-2026-capex-guidance-to-195-205b-cloud-revenue-surges-82/ | 2026-09-24 |
| 17 | LitigationLogic：反壟斷補救生效+雙方上訴（2026-05-22） | https://www.litigationlogic.io/legal-news/google-search-antitrust-remedies-appeal-2026/ | 2026-09-24 |
| 18 | WinBuzzer：DOJ 2026-02-03 交叉上訴求拆 Chrome | https://winbuzzer.com/2026/02/05/doj-appeals-google-antitrust-ruling-chrome-divestiture-xcxwbn/ | 2026-09-24 |
| 19 | NY Post：EU $463M 罰款（2026-09-21） | https://nypost.com/2026/09/21/business/google-hit-with-463-million-fine-for-eu-location-data-rule-breach/ | 2026-09-24 |
| 20 | Reuters：UK CMA 搜尋選擇提議（2026-09-23） | https://www.reuters.com/legal/litigation/uk-regulator-proposes-giving-consumers-more-search-choice-google-2026-09-23/ | 2026-09-24 |
| 21 | Dataconomy/hirenest：Meta 租用 TPU 協議（2026-02-26/27） | https://dataconomy.com/2026/02/27/meta-signs-multibillion-dollar-deal-to-rent-google-tpus-for-ai-training/ | 2026-09-24 |
| 22 | tech-insider：Google $40B 投資 Anthropic @$350B（2026-04-24，中信心） | https://tech-insider.org/google-40-billion-anthropic-investment-tpu-compute-2026/ | 2026-09-24 |
| 23 | Waymo 數據（GCBC 2026-02-13；happycapyguide 2026-03；TechCrunch 2026-09-22；axis-intelligence 未審計） | https://www.goodcarbadcar.net/twelve-cities-16-billion-one-million-rides-waymos-2026-blitz/ 等 | 2026-09-24 |
| 24 | CNBC：Fed 2026-09-16 加息至 3.75-4.00%；10Y>5%；美國財政部每日孳息曲線（2026-09-23：10Y 5.11%/30Y 5.40%） | https://www.cnbc.com/2026/09/16/fed-rate-decision-september-2026.html + https://home.treasury.gov/resource-center/data-chart-center/interest-rates/daily-treasury-rates.csv/2026/all?type=daily_treasury_yield_curve&field_tdr_date_value=2026&page&_format=csv | 2026-09-24 |
| 25 | Invezz：Meta Muse AI 競爭拖累（2026-09-23） | https://invezz.com/news/2026/09/23/alphabet-stock-falls-3-as-metas-muse-ai-raises-competition/ | 2026-09-24 |
| 26 | Google DeepMind：Gemini Robotics 2（2026-07-30） | https://deepmind.google/models/gemini-robotics/ | 2026-09-24 |
| 27 | HANDOVER-PhysicalAI-20260924.md / 筛选公司/PhysicalAI-應用層篩選-20260924.md（本 repo，宏觀債息/五大廠 capex 帳/基線快照） | 本地檔案 | 2026-09-24 |
| 28 | 本 repo 前作：Google-Alphabet投资研究报告-20260623.md | 本地檔案 | 2026-09-24 |
| 29 | Loop Capital Markets：$19.3B 強制可轉換優先股聯席帳簿管理人公告（2026-06-02）；Davis Polk：Series A/B 6.25% 條款 | https://www.loopcapital.com/article/loop-capital-markets-as-co-manager-on-19-3-billion-mandatory-convertible-preferred-stock-offering-for-alphabet-inc/ + https://www.davispolk.com/experience/alphabet-90-billion-equity-and-equity-linked-offerings | 2026-09-24 |

---

### 審計記錄（report_audit.py）

- **第一輪**（無種子抽樣，26 點）：18 通過 / 4 警告 / 4 不通過——4 個「不通過」經複核全部係抽取器揀錯數字（揀咗標籤入面嘅年份或相鄰百分比），數據本身無誤；按流程修正報告措辭令數據點清晰（EV/S 統一 8.9x、HY 債差加現值 418bps、雲增速行改寫、EPS 橋行改寫）後重審。
- **第二輪**（`--seed 42`，26 點）：**26 通過 / 0 警告 / 0 不通過——【准出】**。每點兩個獨立信源（公司財報/SEC 文件、abc.xyz 逐字稿、Yahoo chart API、stockanalysis、macrotrends、TipRanks、beancount、Cleary Gottlieb/Loop Capital、美國財政部、Reuters/NY Post 等），命令與結果可用種子 42 復現。
- 抽中要點包括：股價 $337.83、Q2 收入 $119.8B、TTM OCF $185.7B、capex 指引 $195-205B、Fwd PE 25.24、共識倒退 27.8%、核心 PE 32.3x、優先股 $19.3B、30Y 5.40%、Q1 雲增速 63%、熊市 EPS $14.02。

### 數據信心標註

- 高信心（兩來源交叉）：股價/市值/PE/Fwd PE/FY26-27 EPS 共識/Q2'26 財務/capex 指引/融資包/反壟斷程序/Fed 決議
- 中信心（單一或新聞轉述）：Waymo 營運數字（週單/空駕率/收入）、Anthropic $40B 投資細節、TPU 外銷規模、2027 capex 估計 $250B
- 低信心/觀點：核心 EPS $10.45（自行剔除一次性收益，稅率口徑估計）、三情景概率、買入區 $260-290

*免責：本報告為學習研究用途，唔係投資建議。所有計算可用 `tools/financial_rigor.py` 復現。*
