#!/bin/sh
set -e

# DBマイグレーション実行
echo "Running database migrations..."
bundle exec rails db:migrate

# Pumaサーバー起動（Cloud Runは$PORT環境変数でポートを指定する）
echo "Starting Puma server on port ${PORT:-8080}..."
exec bundle exec puma -C config/puma.rb -p ${PORT:-8080}
