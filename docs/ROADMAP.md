# 🗺️ Bros Nuzlocke Tracker ロードマップ

> 最終更新: 2026年2月14日
> プロジェクトの実装計画と今後の方向性をまとめたドキュメント

---

## 📊 全体の進捗サマリー

| フェーズ | 内容 | 状態 |
|---------|------|------|
| Phase 0 | 基盤構築・コア機能 | ✅ 完了 |
| Phase 1 | マスターデータ・デプロイ準備 | ✅ 完了 |
| Phase 2 | Cloud Run本番デプロイ | ✅ 完了 |
| Phase 3 | 機能の穴埋め・UX改善 | 🔜 次にやる |
| Phase 4 | フロントエンド刷新（React/Vue） | 📌 中期 |
| Phase 5 | ソーシャル・コミュニティ | 💭 長期構想 |

---

## ✅ Phase 0: 基盤構築・コア機能（完了）

すべて実装済み。193テスト全通過確認済み。

### 完了した機能
- [x] **ユーザー認証**（Devise + ゲストログイン）
- [x] **チャレンジ管理**（CRUD + 状態管理: in_progress / completed / failed）
- [x] **ポケモン管理**（捕獲記録・パーティ管理・死亡/ボックス管理）
- [x] **エリア管理**（Areaモデル・エメラルド用15エリア）
- [x] **ルール管理**（デフォルト自動生成・カスタムルール・違反チェック）
- [x] **バトル記録**（バトルタイプ・勝敗・参加ポケモン・MVP）
- [x] **マイルストーン**（ジムバッジ・ストーリー進行の追跡）
- [x] **イベントログ**（捕獲/進化/死亡等のイベント記録）
- [x] **統計ダッシュボード**（Chart.js・月別データ・生存率分析）
- [x] **ボスバトル情報**（ジムリーダー・四天王・チャンピオン）
- [x] **攻略ガイド**（ユーザー投稿型・ガイドタイプ分類）
- [x] **チームビルダー**（タイプ相性分析・おすすめ提案）

### 完了したインフラ・品質改善
- [x] テスト全通過（193 runs, 338 assertions, 0 failures, 0 errors）
- [x] 不要ファイル整理（scripts/、cookies.txt等を削除）
- [x] vendor/bundle をgit管理から除外（200MB軽量化）
- [x] ドキュメント統合（15→9ファイル）
- [x] RuboCop コード品質チェック導入
- [x] Turbo 8・CSS・JavaScriptパフォーマンス最適化
- [x] PostgreSQL prepared statement重複エラー対策

---

## ✅ Phase 1: マスターデータ・デプロイ準備（完了）

### 完了した作業
- [x] **ポケモン図鑑マスターデータ**
  - Gen1: No.1〜151（フシギダネ〜ミュウ）
  - Gen2: No.152〜251（チコリータ〜セレビィ）
  - Gen3: No.252〜386（キモリ〜デオキシス）
  - 全386匹の種族値・タイプ・特性・分類データ
  - 伝説/幻ポケモンフラグ設定
  - Gen6以降のタイプ変更反映（フェアリー等）
- [x] **タイプ相性データ**（18×18 = 324件）
- [x] **PokemonSpeciesモデルのスコープ修正**（SQLite/PostgreSQL両対応）
- [x] **Cloud Run デプロイ設定**
  - Dockerfile（マルチステージビルド, 380MB）
  - docker-entrypoint.sh
  - cloudbuild.yaml（Cloud Build CI/CD）
  - .dockerignore
  - CLOUD_RUN_GUIDE.md

---

## ✅ Phase 2: Cloud Run 本番デプロイ（完了）

> 完了日: 2026年2月14日

### 完了した作業
- [x] **GCPプロジェクト作成** (`pokebros-project`)
  - Cloud Run, Cloud Build, Artifact Registry, Secret Manager API有効化
  - サービスアカウント設定・IAMロール付与
- [x] **環境変数 & シークレット設定**
  - Secret Manager: `DATABASE_URL`, `SECRET_KEY_BASE`, `RAILS_MASTER_KEY`
  - 環境変数: `RAILS_ENV=production`, `RAILS_SERVE_STATIC_FILES=true`, `RAILS_LOG_TO_STDOUT=true`
- [x] **初回デプロイ成功**
  - `gcloud run deploy --source .` でビルド＆デプロイ
  - URL: https://bros-nuzlocke-tracker-509206780612.asia-northeast1.run.app
- [x] **DB マイグレーション & シードデータ投入**
  - Supabase Transaction Pooler（ポート6543）で安定接続
  - `prepared_statements: false` 設定（pgbouncer対応）
  - docker-entrypoint.sh: DB操作バックグラウンド化（ヘルスチェック対策）
- [x] **credentials.yml.enc 再生成**
  - master.key不一致によるInvalidMessage解決

### デプロイ構成
- リージョン: asia-northeast1（東京）
- メモリ: 512Mi / CPU: 1
- インスタンス: min=0, max=3（コスト優先）
- スタートアップ: CPU Boost有効
- データベース: Supabase PostgreSQL（Transaction Pooler + SSL）

### 学んだこと
- Supabase Direct Connection(5432)はIPv6前提 → Cloud RunからはTransaction Pooler(6543)を使う
- シード処理が長いとヘルスチェックでタイムアウト → DB操作をバックグラウンド化
- pgbouncerではPrepared Statementsが使えない → `prepared_statements: false`

---

## 📋 Phase 3: 機能の穴埋め・UX改善

> 優先度: **MEDIUM** | 想定期間: 2〜4週間

### 3-1. 未実装コア機能の追加

| 機能 | 概要 | 難易度 |
|------|------|--------|
| **技構成管理** | ポケモンの技4つを記録・管理 | ★★☆ |
| **進化記録** | 進化前→進化後の記録、進化方法メモ | ★★☆ |
| **死亡エピソード** | 死亡時の状況・思い出を記録するテキストフィールド | ★☆☆ |
| **エリア捕獲状況** | エリアごとの捕獲済み/未捕獲を一覧表示 | ★★☆ |
| **捕獲チェック** | Nuzlockeルールに基づく捕獲可否の自動判定 | ★★★ |
| **難易度プリセット** | イージー/ノーマル/ハード/ハードコアの一括設定 | ★★☆ |
| **エリアデータ拡充** | 赤緑/金銀/ルビサファ等のエリアデータ追加 | ★★☆ |

### 3-2. UX改善

| 改善項目 | 概要 | 難易度 |
|---------|------|--------|
| **通知・フィードバック** | 操作結果のトースト通知表示 | ★☆☆ |
| **ダークモード** | テーマ切り替え機能 | ★★☆ |
| **ローディング表示** | Turbo遷移中のスケルトンUI | ★★☆ |
| **i18n対応** | 日本語/英語の切り替え（config/locales拡充） | ★★★ |
| **PWA対応** | Service Worker + manifest.json でアプリ化 | ★★☆ |

### 3-3. データ品質

| 項目 | 概要 | 難易度 |
|------|------|--------|
| **図鑑データ検証** | 386匹の種族値・タイプの正確性チェック | ★★☆ |
| **Gen4以降のデータ追加** | シンオウ(107匹)・イッシュ(156匹)等 | ★★★ |
| **ボスバトルシードデータ** | ジムリーダー・四天王の公式データ投入 | ★★★ |

---

## 📌 Phase 4: フロントエンド刷新（React/Vue）

> 優先度: **MEDIUM** | 想定期間: 1〜2ヶ月
> 方針: 「ポケモンらしい見た目にこだわりたい」→ モダンなUI/UXへ

### 4-1. 技術選定

| 選択肢 | メリット | デメリット |
|--------|---------|-----------|
| **React + Next.js** | エコシステム最大、求人多い | やや学習コスト高 |
| **Vue + Nuxt.js** | 学習コスト低、直感的 | エコシステムがReactより小さい |
| **React + Vite** | 軽量・高速ビルド | SSR別途設定が必要 |

### 4-2. 移行ステップ

1. **API化**
   - Rails を API モード (JSON) に対応
   - 既存コントローラーに `respond_to :json` 追加
   - API用の認証（JWT or セッション）
2. **フロントエンド基盤構築**
   - React/Vue プロジェクト作成
   - PokeAPI風のデザインシステム構築
   - タイプカラー・ポケモンスプライト統合
3. **画面ごとの移行**
   - ダッシュボード → チャレンジ一覧 → ポケモン管理 → 図鑑 …
   - 段階的に移行（Rails View と React/Vue の共存期間あり）
4. **デプロイ構成変更**
   - フロントエンド: Vercel or Cloud Run
   - バックエンド: Cloud Run（APIサーバー）

### 4-3. ポケモンらしいUI要素

- タイプ別のカラーテーマ（ほのお=赤、みず=青 等）
- ポケモンスプライトのアニメーション表示
- モンスターボール風のUI要素（ボタン、アイコン等）
- 図鑑風のカード表示
- バトル風のエフェクト表示
- レスポンシブ対応のモバイルファーストデザイン

---

## 💭 Phase 5: ソーシャル・コミュニティ（長期構想）

> 優先度: **LOW** | 想定時期: Phase 4 完了後

### 5-1. ソーシャル機能
- [ ] チャレンジの公開/非公開設定
- [ ] 他ユーザーのチャレンジ閲覧
- [ ] いいね・コメント機能
- [ ] ランキング（生存率、完走率、速度等）
- [ ] ユーザープロフィールページ

### 5-2. コミュニティ機能
- [ ] チャレンジ企画・イベント作成
- [ ] 攻略ガイドの投票・評価システム
- [ ] チャレンジ結果の共有（SNS連携）

### 5-3. 高度な分析
- [ ] AI による戦略提案（OpenAI API等）
- [ ] 成功パターン分析（統計的）
- [ ] おすすめパーティ自動生成

---

## 🔧 技術的負債・改善タスク

優先度に関わらず、随時対応すべき技術的な課題。

| タスク | 優先度 | 詳細 |
|--------|--------|------|
| ERBの重複キー警告修正 | LOW | rules/index.html.erb:53, team_builder/_party_pokemon_card.html.erb:80 |
| RuboCop全チェック通過 | LOW | 現在一部警告あり |
| テストカバレッジ拡充 | MEDIUM | システムテスト（Capybara）の追加 |
| セキュリティ監査 | MEDIUM | Brakeman による脆弱性チェック |
| N+1クエリ検出 | LOW | Bullet gem 導入検討 |
| CI/CD パイプライン | MEDIUM | GitHub Actions でテスト自動実行 |
| エラー監視 | LOW | Sentry or Honeybadger 導入 |

---

## 📅 マイルストーン目標

| 時期 | 目標 |
|------|------|
| **2026年2月** | ✅ マスターデータ完成、Cloud Runデプロイ完了 |
| **2026年2〜3月** | Phase 3 機能の穴埋め・UX改善 |
| **2026年4〜5月** | Phase 3 完了、React/Vue 技術選定 |
| **2026年6〜7月** | Phase 4 フロントエンド移行開始 |
| **2026年下半期** | Phase 4 完了、Phase 5 検討開始 |

---

## 📎 関連ドキュメント

| ドキュメント | 内容 |
|-------------|------|
| [REQUIREMENTS.md](REQUIREMENTS.md) | 要件定義書（機能別の実装状況） |
| [DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md) | 開発ガイド（環境構築・コーディング手順） |
| [CLOUD_RUN_GUIDE.md](CLOUD_RUN_GUIDE.md) | Cloud Run デプロイガイド |
| [DATA_SETUP_GUIDE.md](DATA_SETUP_GUIDE.md) | データセットアップガイド |
| [SECURITY_GUIDE.md](SECURITY_GUIDE.md) | セキュリティガイド |
| [SUPABASE_GUIDE.md](SUPABASE_GUIDE.md) | Supabase 設定ガイド |
| [TROUBLESHOOTING_GUIDE.md](TROUBLESHOOTING_GUIDE.md) | トラブルシューティング集 |

---

## 🆕 2026年2月15日 revision 00015

- 統合プレイダッシュボード実装（管理＋進捗＋パーティ管理を1ページ化）
- バッジ・四天王・チャンピオンの非同期切り替え（Badge Stimulusコントローラー）
- チャレンジ一覧から直接プレイ画面へ（🎮 プレイボタン）
- PokeAPIスプライト画像を全ページに表示
- Cloud Runデプロイ（asia-northeast1, revision 00015）
- テスト196件全通過

---

*このロードマップは開発の進行に合わせて随時更新されます。* 🚀✨
