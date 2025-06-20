#!/bin/bash
# Supabaseデータベース接続確認スクリプト �️

echo "🔧 Supabaseデータベース接続確認中..."

# 環境変数をチェック
if [ -z "$DATABASE_URL" ]; then
    echo "❌ DATABASE_URL環境変数が設定されていません"
    echo "📝 .envファイルを作成してDATABASE_URLを設定してください"
    echo "例: DATABASE_URL=postgresql://postgres:password@your-project.supabase.co:5432/postgres"
    exit 1
fi

echo "✅ DATABASE_URL設定確認済み"

# Gemをインストール
echo "� Gemをインストール中..."
bundle install

echo "🔄 マイグレーションを実行..."
RAILS_ENV=development rails db:migrate

echo "🌱 初期データを作成..."
RAILS_ENV=development rails db:seed

echo "✅ Supabaseデータベース設定完了！"

echo "🎮 アプリケーションを起動してください:"
echo "rails server"
