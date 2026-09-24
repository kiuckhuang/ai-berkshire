#!/usr/bin/env python3
"""Physical AI 觀察名單報價更新工具 — 零外部依賴（僅 stdlib）。

配合 `筛选公司/PhysicalAI-應用層篩選-20260924.md` 監察清單每週跑：
讀取 data/physical_ai_masterlist_*.csv 內嘅上市 ticker（自動跳過私人公司），
用 Yahoo Finance chart API 逐個拉最新報價，輸出可 diff 嘅 CSV 快照。

設計原則（跟 tools/twstock_data.py 同風格）：
    - 純 stdlib（urllib + csv），不引入 yfinance 依賴
    - 數據只做快照，唔做任何投資判斷
    - 每個 ticker 失敗不影響其他（標 ERROR 繼續跑）

用法：
    python3 tools/update_physical_ai_quotes.py                  # 用最新 masterlist，輸出 data/physical_ai_quotes_YYYYMMDD.csv
    python3 tools/update_physical_ai_quotes.py --tickers HSAI,SYM
    python3 tools/update_physical_ai_quotes.py --list ISRG --stdout   # 只印表不寫檔
    python3 tools/update_physical_ai_quotes.py --masterlist data/physical_ai_masterlist_20260924.csv

輸出欄位：
    層級, 公司, Ticker, 幣別, 股價, 前收市, 52週高, 52週低, 52週變化%,
    年初至今%, 報價時間(UTC), 監察重點, 備註

注意：
    - 52週變化% 以 ~1 年前收市（chartPreviousClose，range=1y）為基準，屬近似值
    - 日本/上交所 ticker 以當地貨幣報價（JPY/CNY），比較時注意匯率
    - 價格數據來源：Yahoo Finance chart API（與篩選報告同一來源，另有
      stockanalysis.com 可作第二來源交叉）
    - 本工具只取數，唔構成投資建議
"""

import argparse
import csv
import datetime
import glob
import json
import os
import sys
import time
import urllib.request
import urllib.error

YAHOO_CHART = "https://query1.finance.yahoo.com/v8/finance/chart/{ticker}?range=1y&interval=1d"
HEADERS = {"User-Agent": "Mozilla/5.0 (compatible; ai-berkshire-research/1.0)"}
MASTERLIST_GLOB = "data/physical_ai_masterlist_*.csv"
RETRIES = 2
RETRY_WAIT = 2  # seconds
FETCH_PAUSE = 1.0  # politeness pause between tickers


def fetch_quote(ticker, timeout=20):
    """拉單一 ticker 嘅 Yahoo chart 數據，返回 dict（或拋異常）。"""
    url = YAHOO_CHART.format(ticker=ticker)
    req = urllib.request.Request(url, headers=HEADERS)
    last_err = None
    for _ in range(RETRIES):
        try:
            with urllib.request.urlopen(req, timeout=timeout) as resp:
                payload = json.load(resp)
            result = payload["chart"]["result"][0]
            meta = result["meta"]
            closes = [
                c for c in (result.get("indicators", {}).get("quote", [{}])[0].get("close") or [])
                if c is not None
            ]
            ytd_base = None
            timestamps = result.get("timestamp") or []
            if timestamps and closes:
                years = {
                    datetime.datetime.fromtimestamp(t, datetime.timezone.utc).year
                    for t in timestamps
                }
                # 找今年第一個交易日嘅收市，做 YTD 基準
                for t, c in zip(timestamps, closes):
                    if datetime.datetime.fromtimestamp(t, datetime.timezone.utc).year == max(years):
                        ytd_base = c
                        break
            chg_1y = None
            base_1y = meta.get("chartPreviousClose")
            if base_1y and meta.get("regularMarketPrice"):
                chg_1y = round((meta["regularMarketPrice"] / base_1y - 1) * 100, 1)
            chg_ytd = None
            if ytd_base and meta.get("regularMarketPrice"):
                chg_ytd = round((meta["regularMarketPrice"] / ytd_base - 1) * 100, 1)
            return {
                "股價": meta.get("regularMarketPrice"),
                # 只用真前收市；chartPreviousClose 係一年前收市，語義唔同，唔可以拎嚟填
                "前收市": meta.get("previousClose", ""),
                "52週高": meta.get("fiftyTwoWeekHigh"),
                "52週低": meta.get("fiftyTwoWeekLow"),
                "幣別": meta.get("currency"),
                "52週變化%": chg_1y,
                "年初至今%": chg_ytd,
                "報價時間(UTC)": datetime.datetime.fromtimestamp(
                    meta.get("regularMarketTime", time.time()), datetime.timezone.utc
                ).strftime("%Y-%m-%d %H:%M"),
            }
        except (urllib.error.URLError, KeyError, IndexError, ValueError, TimeoutError) as exc:
            last_err = exc
            time.sleep(RETRY_WAIT)
    raise RuntimeError(f"{ticker}: {last_err}")


def load_masterlist(path):
    """讀 masterlist CSV，返回 [(層級, 公司, Ticker, 監察重點), ...]，跳過私人/無 ticker 行。"""
    rows = []
    with open(path, newline="", encoding="utf-8-sig") as fh:
        reader = csv.DictReader(fh)
        for row in reader:
            ticker = (row.get("Ticker") or "").strip()
            if not ticker or ticker == "—" or "私人" in (row.get("層級") or ""):
                continue
            rows.append(
                {
                    "層級": (row.get("層級") or "").strip(),
                    "公司": (row.get("公司") or "").strip(),
                    "Ticker": ticker,
                    "監察重點": (row.get("監察重點") or "").strip(),
                }
            )
    return rows


def latest_masterlist():
    candidates = sorted(glob.glob(MASTERLIST_GLOB))
    if not candidates:
        raise SystemExit(f"找不到 masterlist：{MASTERLIST_GLOB}")
    return candidates[-1]


def main():
    parser = argparse.ArgumentParser(description="Physical AI 觀察名單報價更新（Yahoo Finance，stdlib-only）")
    parser.add_argument("--masterlist", help="指定 masterlist CSV（默認自動揀最新）")
    parser.add_argument("--tickers", help="逗號分隔 ticker，覆蓋 masterlist（例如 HSAI,SYM）")
    parser.add_argument("--stdout", action="store_true", help="印表到 stdout，不寫 CSV")
    parser.add_argument("--out", help="輸出檔案路徑（默認 data/physical_ai_quotes_YYYYMMDD.csv）")
    args = parser.parse_args()

    path = args.masterlist or latest_masterlist()
    meta_rows = load_masterlist(path)
    if args.tickers:
        wanted = [t.strip().upper() for t in args.tickers.split(",") if t.strip()]
        meta_rows = [r for r in meta_rows if r["Ticker"].upper() in wanted]
        known = {r["Ticker"].upper() for r in meta_rows}
        meta_rows += [
            {"層級": "", "公司": t, "Ticker": t, "監察重點": ""}
            for t in wanted
            if t not in known
        ]
    else:
        meta_rows = meta_rows
    if not meta_rows:
        raise SystemExit("沒有可查詢嘅 ticker")

    print(f"masterlist: {path}（{len(meta_rows)} 個 ticker）", file=sys.stderr)
    out_rows, errors = [], []
    for i, m in enumerate(meta_rows):
        try:
            q = fetch_quote(m["Ticker"])
            note = ""
        except Exception as exc:  # 單一失敗不停機
            q, note = {}, f"ERROR: {exc}"
            errors.append(m["Ticker"])
        out_rows.append(
            {
                "層級": m["層級"],
                "公司": m["公司"],
                "Ticker": m["Ticker"],
                "幣別": q.get("幣別", ""),
                "股價": q.get("股價", ""),
                "前收市": q.get("前收市", ""),
                "52週高": q.get("52週高", ""),
                "52週低": q.get("52週低", ""),
                "52週變化%": q.get("52週變化%", ""),
                "年初至今%": q.get("年初至今%", ""),
                "報價時間(UTC)": q.get("報價時間(UTC)", ""),
                "監察重點": m["監察重點"],
                "備註": note,
            }
        )
        status = f"{m['Ticker']}: {q.get('股價', '失敗')}"
        print(f"  [{i + 1}/{len(meta_rows)}] {status}", file=sys.stderr)
        if i < len(meta_rows) - 1:
            time.sleep(FETCH_PAUSE)

    if args.stdout:
        writer = csv.DictWriter(sys.stdout, fieldnames=list(out_rows[0].keys()))
        writer.writeheader()
        writer.writerows(out_rows)
    else:
        today = datetime.date.today().strftime("%Y%m%d")
        out_path = args.out or f"data/physical_ai_quotes_{today}.csv"
        os.makedirs(os.path.dirname(out_path) or ".", exist_ok=True)
        with open(out_path, "w", newline="", encoding="utf-8") as fh:
            writer = csv.DictWriter(fh, fieldnames=list(out_rows[0].keys()))
            writer.writeheader()
            writer.writerows(out_rows)
        print(f"已寫入 {out_path}", file=sys.stderr)

    if errors:
        print(f"警告：{len(errors)} 個 ticker 失敗（見備註欄）", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
