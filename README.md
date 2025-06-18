# Bros Nuzlocke Tracker 🎮✨

ポケモンのナズロックチャレンジを管理するWebアプリケーション

## 開発環境セットアップ

### 必要な環境
- Ruby 3.3.4
- Rails 8.0.2
- Node.js 18+ (アセット管理用)
- PostgreSQL (本番環境用)
- Yarn (パッケージ管理)

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
```

### 開発コマンド

```bash
# 開発サーバー起動
bin/rails server

# テスト実行
bin/rails test

# コード品質チェック
bin/rubocop            # Lintチェック
bin/rubocop -a         # 自動修正

# アセット管理
yarn install           # JS依存関係インストール
bin/rails assets:precompile  # アセットプリコンパイル
```

### デプロイ

本番環境は[Render.com](https://render.com/)にデプロイされます。

```bash
# 変更をプッシュするだけで自動デプロイ
git add .
git commit -m "Update features"
git push origin main
```

#### 手動デプロイ（必要に応じて）
1. Renderダッシュボードにアクセス
2. サービスを選択
3. "Deploy latest commit"をクリック

## 主要機能

- 🔐 ユーザー認証（Devise）
- 🎯 チャレンジ管理
- 🐾 ポケモン捕獲記録
- 📋 カスタムルール設定
- 📊 チャレンジ統計
- 🎨 レスポンシブUI（Bootstrap 5）

## 技術スタック

- **Backend**: Ruby on Rails 8.0.2
- **Frontend**: Bootstrap 5 + Stimulus + Turbo
- **Database**: SQLite (開発), PostgreSQL (本番)
- **Deploy**: Render.com
- **Assets**: Importmap + Sass

## トラブルシューティング

### アセットプリコンパイルエラー
```bash
# 依存関係を再インストール
rm yarn.lock
yarn install

# アセットをクリア
bin/rails assets:clobber
bin/rails assets:precompile
```

### データベース接続エラー
```bash
# PostgreSQL設定確認（本番）
echo $DATABASE_URL

# 開発環境でのDB再作成
bin/rails db:drop db:create db:migrate
```
