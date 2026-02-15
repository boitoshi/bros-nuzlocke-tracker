# Bros Nuzlocke Tracker 🎮✨

ポケモンのナズロックチャレンジを管理するWebアプリケーション

## 🎯 アプリケーション概要

このアプリはポケモンのナズロックチャレンジ（縛りプレイ）を簡単に記録・管理できるWebアプリです。
シンプルで使いやすい設計を心がけており、初心者でも簡単に開発に参加できます。

### 主要機能
- 👤 **ユーザー管理** - ログイン・新規登録
- 🎮 **チャレンジ管理** - ゲームタイトル別のチャレンジ作成
- 🐾 **ポケモン管理** - 捕獲記録・パーティ編成・状態管理
- 📋 **ルール設定** - カスタマイズ可能なナズロックルール
- 📊 **統計ダッシュボード** - 進捗確認・グラフ表示
- 🎯 **ゲスト体験モード** - 登録不要でデモ機能を試用可能

## 🛠 技術スタック（シンプル構成）

- **Backend**: Ruby on Rails 8.0 + PostgreSQL (Supabase) / テスト環境: SQLite
- **Frontend**: Bootstrap 5 + Stimulus + Turbo
- **認証**: Devise
- **デプロイ**: Render.com（Cloud Run移行予定）
- **アセット**: Importmap + Sass

## 🚀 開発環境セットアップ

### 必要な環境
- **Ruby**: system (GitHub Codespaces推奨)
- **Rails**: 8.0.2
- **Node.js**: 18+ (Bootstrap/Stimulus用)
- **PostgreSQL**: 本番はSupabase、テストはSQLite

### セットアップ手順

```bash
# リポジトリクローン
git clone <repository-url>
cd bros-nuzlocke-tracker

# 依存関係インストール
bundle install
yarn install

# データベースセットアップ
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed

# 開発サーバー起動
bin/rails server
# => http://localhost:3000 でアクセス
```

## 🎮 テストユーザー・ゲストモード

### ゲスト体験モード（登録不要）
アプリの機能を手軽に体験したい場合：

1. **ホームページにアクセス**
2. **「ゲスト体験」ボタンをクリック**
3. **デモユーザーとして自動ログイン** 🎮

**デモデータ内容：**
- サンプルチャレンジ（ポケモンエメラルド版）
- 6匹のポケモン（生存・死亡・ボックス状態の例）
- ジムバッジ3個の進行状況
- 詳細なイベントログと統計データ

### テストユーザーアカウント
開発・デバッグ用のテストユーザー：

```bash
# シードデータで作成されるテストアカウント
bin/rails db:seed  # まず初期データを作成

# 🔑 管理者アカウント
Username: admin
Email: admin@bros-nuzlocke-tracker.com
Password: AdminPass123!

# 👤 一般テストユーザー
Username: testuser
Email: test@example.com
Password: TestPass123!

# 🎮 デモユーザー（ゲスト体験用）
Username: demouser
Email: demo@example.com
Password: DemoPass123!
```

**使い方：**
1. ログインページで上記の認証情報を入力
2. または「ゲスト体験」ボタンで`demouser`に自動ログイン
3. 各ユーザーで異なるデータ状態を確認可能

### 開発コマンド

```bash
# 🖥️ 開発サーバー
bin/rails server                    # サーバー起動
bin/rails console                   # Railsコンソール

# 🧪 テスト
bin/rails test                      # 全テスト実行
bin/rails test test/models/         # モデルテストのみ

# 🗄️ データベース
bin/rails db:migrate                # マイグレーション実行
bin/rails db:seed                   # 初期データ投入
bin/rails db:reset                  # DB完全リセット

# 🎨 アセット
yarn install                        # JS依存関係更新
bin/rails assets:precompile         # アセットビルド（本番用）

# 🔍 デバッグ・品質
bundle exec rubocop                 # コード品質チェック
bundle exec brakeman                # セキュリティチェック
```

## 🚀 デプロイ

本番環境は[Render.com](https://render.com/)で自動デプロイされます。
シンプルな設定で複雑なDocker設定は不要です。

```bash
# ✅ 通常のデプロイ（自動）
git add .
git commit -m "機能追加: ○○機能を実装"
git push origin main
# => Renderが自動でビルド・デプロイ開始

# 📊 デプロイ状況確認
# 1. Render Dashboard: https://dashboard.render.com/
# 2. プロジェクトを選択
# 3. "Events"タブでログ確認
```

### デプロイ構成（render.yaml）
- **Web Service**: Rails アプリケーション
- **Database**: PostgreSQL (Supabase)
- **環境変数**: 自動設定（DATABASE_URL等）

## 🚀 最新アップデート（2026年2月15日 revision 00015）

- **統合プレイダッシュボード**: ポケモン管理＋進捗＋パーティ管理を1ページに集約
- **バッジ・四天王・チャンピオンの非同期切り替え**: Badge Stimulusコントローラーでページリロード不要
- **チャレンジ一覧→直接プレイ画面**: 「🎮 プレイ」ボタンで即アクセス
- **PokeAPIスプライト画像**: 全ページに公式スプライト表示
- **Cloud Runデプロイ**: GCP asia-northeast1, revision 00015

### ☁️ Cloud Runデプロイ手順

```bash
git add .
git commit -m "機能追加: 統合ダッシュボード/バッジ非同期化"
git push origin main

gcloud run deploy bros-nuzlocke-tracker \
  --source . \
  --region asia-northeast1 \
  --allow-unauthenticated \
  --set-env-vars "RAILS_ENV=production,RAILS_SERVE_STATIC_FILES=true,RAILS_LOG_TO_STDOUT=true" \
  --update-secrets "DATABASE_URL=DATABASE_URL:latest,SECRET_KEY_BASE=SECRET_KEY_BASE:latest,RAILS_MASTER_KEY=RAILS_MASTER_KEY:latest" \
  --memory 512Mi --cpu 1 \
  --min-instances 0 --max-instances 3 \
  --timeout 300 --cpu-boost \
  --command "./docker-entrypoint.sh"
```

- サービスURL: https://bros-nuzlocke-tracker-509206780612.asia-northeast1.run.app
- revision: 00015

## 📁 プロジェクト構成

```
bros-nuzlocke-tracker/
├── app/
│   ├── controllers/         # 12コントローラー
│   │   ├── challenges_controller.rb    # チャレンジ管理
│   │   ├── pokemons_controller.rb      # ポケモン管理
│   │   ├── battle_records_controller.rb # バトル記録
│   │   ├── team_builder_controller.rb  # チームビルダー
│   │   ├── dashboard_controller.rb     # 統計・ダッシュボード
│   │   ├── statistics_controller.rb    # 詳細統計
│   │   ├── boss_battles_controller.rb  # ボス戦情報
│   │   └── ...
│   ├── models/              # 14モデル
│   │   ├── user.rb          # ユーザー情報
│   │   ├── challenge.rb     # チャレンジ情報
│   │   ├── pokemon.rb       # ポケモン情報
│   │   ├── battle_record.rb # バトル記録
│   │   ├── area.rb          # ゲーム内エリア
│   │   ├── boss_battle.rb   # ボス戦データ
│   │   └── ...
│   └── views/               # HTMLテンプレート
├── config/
│   ├── database.yml         # DB設定
│   └── routes.rb            # URL設定
├── docs/                    # ドキュメント（8ファイル）
├── render.yaml              # Renderデプロイ設定
└── README.md                # このファイル
```

## 🎮 主要機能の詳細

### 1. 👤 ユーザー管理（Devise）
- 新規登録・ログイン・ログアウト
- セッション管理
- パスワードリセット

### 2. 🎯 チャレンジ管理
- ゲームタイトル選択（赤・緑・金・銀・ルビー・サファイア等）
- チャレンジステータス管理（進行中・完了・失敗）
- 開始日・完了日の記録

### 3. 🐾 ポケモン管理
- 捕獲記録（種族・ニックネーム・レベル・エリア）
- パーティ管理（最大6匹）
- 状態管理（生存・死亡・ボックス）

### 4. 📋 ルール設定
- プリセットルール（一匹縛り・フェアリー禁止等）
- カスタムルール作成
- ルール違反チェック

### 5. 📊 統計ダッシュボード
- チャレンジ成功率
- ポケモン捕獲統計
- Chart.jsによるグラフ表示

## 🛠 トラブルシューティング

### よくある問題と解決方法

#### アセット関連エラー
```bash
# ❌ Bootstrap/CSSが正しく表示されない
yarn install                         # 依存関係再インストール
bin/rails assets:clobber            # アセットキャッシュクリア
bin/rails assets:precompile         # アセット再ビルド
```

#### データベース接続エラー
```bash
# ❌ PG::ConnectionBad エラー
# 本番環境（Render）
echo $DATABASE_URL                   # 環境変数確認

# 開発環境
bin/rails db:drop                    # DB削除
bin/rails db:create                  # DB作成
bin/rails db:migrate                 # マイグレーション
bin/rails db:seed                    # 初期データ
```

#### Ruby LSP / RuboCop エラー
```bash
# ❌ Ruby LSP が動作しない
# VS Code Command Palette > "Ruby LSP: Restart"

# ❌ RuboCop設定エラー
bundle exec rubocop --version       # インストール確認
# 設定ファイル確認: .rubocop.yml（シンプル構成推奨）
```

#### Yarn/Node.js エラー
```bash
# ❌ yarn install が失敗する
rm -rf node_modules yarn.lock       # クリーンアップ
yarn install                        # 再インストール

# ❌ importmap エラー
bin/rails importmap:install         # importmap再インストール
```

## 📚 関連ドキュメント

| ドキュメント | 内容 |
|---|---|
| [開発ガイド](docs/DEVELOPMENT_GUIDE.md) | 環境構築・機能追加・テスト |
| [データセットアップ](docs/DATA_SETUP_GUIDE.md) | DB・シード・フィクスチャ |
| [Supabaseガイド](docs/SUPABASE_GUIDE.md) | Supabase設定・接続 |
| [トラブルシューティング](docs/TROUBLESHOOTING_GUIDE.md) | よくある問題と解決 |
| [要件定義書](docs/REQUIREMENTS.md) | 機能要件・非機能要件 |
| [セキュリティ](docs/SECURITY_GUIDE.md) | セキュリティ対策 |
| [商用利用](docs/COMMERCIAL_USE_GUIDE.md) | 商用利用ガイド |
| [ポケモン図鑑DB](docs/POKEMON_DATABASE_DESIGN.md) | 図鑑データベース設計 |

## 🤝 コントリビューション

1. このリポジトリをフォーク
2. 機能ブランチを作成 (`git checkout -b feature/amazing-feature`)
3. 変更をコミット (`git commit -m 'Add amazing feature'`)
4. ブランチにプッシュ (`git push origin feature/amazing-feature`)
5. プルリクエストを作成

## 📄 ライセンス

このプロジェクトは [MIT License](LICENSE) の下で公開されています。
