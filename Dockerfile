# =============================================================================
# Bros Nuzlocke Tracker - Dockerfile (Cloud Run用)
# マルチステージビルドでイメージサイズを最小化 🐳
# =============================================================================

# ---------------------------------------------------------------------------
# ステージ1: ビルドステージ
# Gem・Node.jsパッケージのインストールとアセットプリコンパイルを行う
# ---------------------------------------------------------------------------
FROM ruby:3.4-slim AS build

# ビルドに必要なパッケージをインストール
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    curl \
    git \
    libpq-dev \
    libsqlite3-dev \
    libyaml-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Node.js 20.x と Yarn をインストール（アセットビルド用）
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install --no-install-recommends -y nodejs && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを設定
WORKDIR /rails

# Gemfile をコピーして bundle install（キャッシュ効率化のため先にコピー）
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local without "development test" && \
    bundle install --jobs 4 --retry 3 && \
    rm -rf ~/.bundle/cache /usr/local/bundle/cache/*.gem && \
    find /usr/local/bundle/gems/ -name "*.c" -delete && \
    find /usr/local/bundle/gems/ -name "*.o" -delete

# Node.js パッケージをインストール
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile --production

# アプリケーションコード全体をコピー
COPY . .

# アセットプリコンパイル（DB接続なしで実行）
# DATABASE_URLにダミーSQLite設定を使ってDB接続をスキップ
RUN SECRET_KEY_BASE=dummy \
    RAILS_ENV=production \
    DATABASE_URL="sqlite3:///dev/null" \
    ./bin/rails assets:precompile

# ---------------------------------------------------------------------------
# ステージ2: 実行ステージ
# ランタイムに必要な最小限のパッケージのみ含む軽量イメージ
# ---------------------------------------------------------------------------
FROM ruby:3.4-slim AS runtime

# ランタイムに必要なパッケージをインストール
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    libpq5 \
    libvips \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを設定
WORKDIR /rails

# アプリ実行用ユーザーを作成（root権限で実行しない）
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash

# ビルドステージからGemとアプリケーションコードをコピー
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# エントリポイントスクリプトに実行権限を付与
RUN chmod +x /rails/docker-entrypoint.sh

# ファイルのオーナーをrailsユーザーに変更
RUN chown -R rails:rails /rails/db /rails/log /rails/tmp /rails/storage

# 環境変数を設定
ENV RAILS_ENV=production \
    RAILS_SERVE_STATIC_FILES=true \
    RAILS_LOG_TO_STDOUT=true \
    BUNDLE_WITHOUT="development:test"

# railsユーザーに切り替え
USER rails

# Cloud Runは$PORT環境変数でポートを指定してくる（デフォルト8080）
EXPOSE 8080

# エントリポイントスクリプトを実行
ENTRYPOINT ["/rails/docker-entrypoint.sh"]
