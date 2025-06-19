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

## 🛠 技術スタック（シンプル構成）

- **Backend**: Ruby on Rails 8.0 + PostgreSQL
- **Frontend**: Bootstrap 5 + Stimulus + Turbo
- **認証**: Devise
- **デプロイ**: Render.com
- **アセット**: Importmap + Sass

## 🚀 開発環境セットアップ

### 必要な環境
- **Ruby**: system (GitHub Codespaces推奨)
- **Rails**: 8.0.2
- **Node.js**: 18+ (Bootstrap/Stimulus用)
- **PostgreSQL**: 開発時はローカル、本番はRender管理

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
- **Database**: PostgreSQL (Render管理)
- **環境変数**: 自動設定（DATABASE_URL等）

## 📁 プロジェクト構成

```
bros-nuzlocke-tracker/
├── app/
│   ├── controllers/         # 4つのメインコントローラー
│   │   ├── challenges_controller.rb    # チャレンジ管理
│   │   ├── pokemons_controller.rb      # ポケモン管理
│   │   ├── dashboard_controller.rb     # 統計・ダッシュボード
│   │   └── home_controller.rb          # トップページ
│   ├── models/              # 4つのメインモデル
│   │   ├── user.rb          # ユーザー情報
│   │   ├── challenge.rb     # チャレンジ情報
│   │   ├── pokemon.rb       # ポケモン情報
│   │   └── area.rb          # ゲーム内エリア
│   └── views/               # HTMLテンプレート
├── config/
│   ├── database.yml         # DB設定（シンプル構成）
│   └── routes.rb           # URL設定
├── render.yaml             # デプロイ設定
└── README.md              # このファイル
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

- [**開発ガイド**](DEVELOPMENT_GUIDE.md) - 機能開発・修正の詳細手順
- [**シンプルガイド**](SIMPLE_GUIDE.md) - アプリケーション構成の解説
- [**デプロイガイド**](SSH_CONNECTION_GUIDE.md) - 本番環境の設定方法

## 🤝 コントリビューション

1. このリポジトリをフォーク
2. 機能ブランチを作成 (`git checkout -b feature/amazing-feature`)
3. 変更をコミット (`git commit -m 'Add amazing feature'`)
4. ブランチにプッシュ (`git push origin feature/amazing-feature`)
5. プルリクエストを作成

## 📄 ライセンス

このプロジェクトは [MIT License](LICENSE) の下で公開されています。
