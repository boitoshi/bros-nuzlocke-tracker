# Bros Nuzlocke Tracker 🎮✨

ポケモンのナズロックチャレンジを管理するWebアプリケーション

## 開発環境セットアップ

### 必要な環境
- Ruby 3.3.4
- Rails 8.0.2
- Node.js 18+ (アセット管理用)
- PostgreSQL (本番環境用)

### セットアップ手順

```bash
# リポジトリクローン
git clone <repository-url>
cd bros-nuzlocke-tracker

# 自動セットアップ（推奨）
bin/setup

# または手動セットアップ
bundle install
bin/rails db:prepare
bin/rails server
```

### 開発コマンド

```bash
# 開発サーバー起動
bin/dev                 # 推奨（CSS/JSも自動コンパイル）
bin/rails server        # Railsサーバーのみ

# テスト実行
bin/rails test

# コード品質チェック
bin/rubocop            # Lintチェック
bin/rubocop -a         # 自動修正
bin/brakeman           # セキュリティ監査
```

### デプロイ

本番環境はKamalでDockerコンテナとして自動デプロイされます。

```bash
bin/kamal setup    # 初回のみ
bin/kamal deploy   # デプロイ
```

## 主要機能

- 🔐 ユーザー認証（Devise）
- 🎯 チャレンジ管理
- 🐾 ポケモン捕獲記録
- 📋 カスタムルール設定
- 📊 チャレンジ統計

## 技術スタック

- **Backend**: Ruby on Rails 8.0.2
- **Frontend**: Bootstrap 5 + Stimulus
- **Database**: SQLite (開発), PostgreSQL (本番)
- **Deploy**: Kamal + Docker
