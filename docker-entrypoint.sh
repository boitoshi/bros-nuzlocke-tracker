#!/bin/sh
set -e

echo "=========================================="
echo "🚀 Bros Nuzlocke Tracker - Starting up..."
echo "=========================================="
echo "RAILS_ENV: ${RAILS_ENV:-development}"
echo "PORT: ${PORT:-8080}"

# DB操作を実行する関数
run_db_setup() {
  echo "⏳ Checking database connection..."
  retries=0
  max_retries=10
  until bundle exec rails db:version > /dev/null 2>&1; do
    retries=$((retries + 1))
    if [ $retries -ge $max_retries ]; then
      echo "⚠️  Database connection failed after ${max_retries} attempts."
      return 1
    fi
    echo "  Waiting for database... (attempt ${retries}/${max_retries})"
    sleep 3
  done
  echo "✅ Database connected!"

  # DBマイグレーション実行
  echo "📦 Running database migrations..."
  bundle exec rails db:migrate
  echo "✅ Migrations complete!"

  # 初回デプロイ時にシードデータを投入（PokemonSpeciesが0件なら初回と判定）
  SPECIES_COUNT=$(bundle exec rails runner "puts PokemonSpecies.count" 2>/dev/null || echo "0")
  if [ "$SPECIES_COUNT" = "0" ]; then
    echo "🌱 First deploy detected - seeding database..."
    bundle exec rails db:seed
    echo "✅ Seed data loaded!"
  else
    echo "📋 Database already seeded (${SPECIES_COUNT} species found)"
  fi
}

# DB操作をバックグラウンドで実行（Pumaの起動をブロックしない）
# Cloud Runのヘルスチェック(/up)はDB不要で応答できるため、先にPumaを起動する
echo "🔄 Starting DB setup in background..."
(run_db_setup 2>&1 || echo "⚠️  DB setup had issues, check logs.") &

# Pumaサーバー起動（Cloud Runは$PORT環境変数でポートを指定する）
# DB操作完了を待たずに即起動 → ヘルスチェックに素早く応答
echo "=========================================="
echo "🎮 Starting Puma server on port ${PORT:-8080}..."
echo "=========================================="
exec bundle exec puma -C config/puma.rb -p ${PORT:-8080}
