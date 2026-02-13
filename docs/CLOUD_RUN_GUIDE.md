# Cloud Run デプロイガイド ☁️

Bros Nuzlocke TrackerをGoogle Cloud Runにデプロイする手順を解説します。

---

## 目次

1. [前提条件](#前提条件)
2. [初回セットアップ](#初回セットアップ)
3. [環境変数の設定](#環境変数の設定)
4. [デプロイ方法](#デプロイ方法)
5. [Cloud Run環境変数の設定](#cloud-run環境変数の設定)
6. [無料枠について](#無料枠について)
7. [トラブルシューティング](#トラブルシューティング)

---

## 前提条件

- **Google Cloudアカウント**が作成済みであること
- **gcloud CLI**がインストール済みであること（[インストール手順](https://cloud.google.com/sdk/docs/install)）
- **Google Cloudプロジェクト**が作成済みであること
- **Docker**がローカルにインストール済みであること（方法Bの場合）

---

## 初回セットアップ

### 1. gcloud認証とプロジェクト設定

```bash
# Google Cloudにログイン
gcloud auth login

# プロジェクトを設定（YOUR_PROJECT_IDを実際のIDに置き換える）
gcloud config set project YOUR_PROJECT_ID

# リージョンを東京に設定
gcloud config set run/region asia-northeast1
```

### 2. 必要なAPIを有効化

```bash
# Cloud Run API
gcloud services enable run.googleapis.com

# Cloud Build API
gcloud services enable cloudbuild.googleapis.com

# Artifact Registry API（Dockerイメージ保存用）
gcloud services enable artifactregistry.googleapis.com
```

### 3. Artifact Registryリポジトリの作成

Dockerイメージを保存するためのリポジトリを作成します。

```bash
gcloud artifacts repositories create bros-nuzlocke-tracker \
  --repository-format=docker \
  --location=asia-northeast1 \
  --description="Bros Nuzlocke Tracker Docker images"
```

### 4. Cloud Buildにデプロイ権限を付与

Cloud BuildからCloud Runにデプロイするための権限を設定します。

```bash
# プロジェクト番号を取得
PROJECT_NUMBER=$(gcloud projects describe $(gcloud config get-value project) --format='value(projectNumber)')

# Cloud BuildサービスアカウントにCloud Run管理者権限を付与
gcloud projects add-iam-policy-binding $(gcloud config get-value project) \
  --member="serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com" \
  --role="roles/run.admin"

# Cloud BuildサービスアカウントにサービスアカウントUser権限を付与
gcloud projects add-iam-policy-binding $(gcloud config get-value project) \
  --member="serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com" \
  --role="roles/iam.serviceAccountUser"
```

---

## 環境変数の設定

Cloud Runで必要な環境変数は以下の通りです。

| 環境変数 | 説明 | 例 |
|---------|------|-----|
| `DATABASE_URL` | Supabase PostgreSQL接続文字列 | `postgres://user:pass@host:5432/dbname` |
| `SECRET_KEY_BASE` | Railsシークレットキー | `rails secret`で生成 |
| `RAILS_ENV` | Rails環境 | `production` |
| `RAILS_SERVE_STATIC_FILES` | 静的ファイル配信 | `true` |
| `RAILS_MASTER_KEY` | 暗号化キー（必要な場合） | `config/master.key`の内容 |

### SECRET_KEY_BASEの生成

```bash
# ローカルでシークレットキーを生成
bin/rails secret
```

### DATABASE_URLの形式（Supabase）

```
postgres://postgres.xxxxx:PASSWORD@aws-0-ap-northeast-1.pooler.supabase.com:6543/postgres
```

> ⚠️ Supabaseの接続文字列は「Project Settings > Database > Connection string > URI」から取得できます。SSL接続が必要な場合は末尾に `?sslmode=require` を追加してください。

---

## デプロイ方法

### 方法A: Cloud Buildで自動ビルド＆デプロイ（推奨）

Cloud Buildを使うと、ビルドからデプロイまで一括で行えます。

```bash
# プロジェクトルートで実行
gcloud builds submit --config cloudbuild.yaml
```

> 初回ビルドには5〜10分程度かかります。2回目以降はキャッシュにより短縮されます。

### 方法B: ローカルでDockerビルドしてデプロイ

ローカルでビルド・テストしてからデプロイしたい場合に使います。

```bash
# 1. Dockerイメージをビルド
docker build -t bros-nuzlocke-tracker .

# 2. ローカルでテスト実行（オプション）
docker run -p 8080:8080 \
  -e DATABASE_URL="postgres://..." \
  -e SECRET_KEY_BASE="your-secret-key" \
  -e RAILS_ENV=production \
  bros-nuzlocke-tracker

# 3. Artifact Registryにログイン
gcloud auth configure-docker asia-northeast1-docker.pkg.dev

# 4. イメージにタグ付け
docker tag bros-nuzlocke-tracker \
  asia-northeast1-docker.pkg.dev/YOUR_PROJECT_ID/bros-nuzlocke-tracker/bros-nuzlocke-tracker:latest

# 5. イメージをプッシュ
docker push \
  asia-northeast1-docker.pkg.dev/YOUR_PROJECT_ID/bros-nuzlocke-tracker/bros-nuzlocke-tracker:latest

# 6. Cloud Runにデプロイ
gcloud run deploy bros-nuzlocke-tracker \
  --image asia-northeast1-docker.pkg.dev/YOUR_PROJECT_ID/bros-nuzlocke-tracker/bros-nuzlocke-tracker:latest \
  --region asia-northeast1 \
  --platform managed \
  --allow-unauthenticated \
  --port 8080
```

---

## Cloud Run環境変数の設定

デプロイ後に環境変数を設定（または更新）します。

```bash
gcloud run services update bros-nuzlocke-tracker \
  --region asia-northeast1 \
  --set-env-vars "\
DATABASE_URL=postgres://user:password@host:5432/dbname,\
SECRET_KEY_BASE=your-secret-key-base-here,\
RAILS_ENV=production,\
RAILS_SERVE_STATIC_FILES=true,\
RAILS_LOG_TO_STDOUT=true"
```

### RAILS_MASTER_KEYが必要な場合

`config/credentials.yml.enc` を使っている場合は、`RAILS_MASTER_KEY` も設定してください。

```bash
# master.keyの内容を環境変数として設定
gcloud run services update bros-nuzlocke-tracker \
  --region asia-northeast1 \
  --update-env-vars "RAILS_MASTER_KEY=$(cat config/master.key)"
```

---

## 無料枠について

Google Cloudの無料枠（Always Free）を活用すれば、小〜中規模のアプリは無料で運用できます。

| サービス | 無料枠 | 備考 |
|---------|--------|------|
| **Cloud Run** | 月200万リクエスト | CPU: 180,000 vCPU秒、メモリ: 360,000 GiB秒 |
| **Cloud Build** | 月120分 | ビルド時間の合計 |
| **Artifact Registry** | 500MB | Dockerイメージの保存容量 |

> 💡 Cloud Runは最小インスタンス数を0にしておけば、アクセスがない時はコストが発生しません。ただし、コールドスタート（初回アクセス時の遅延）が発生する点に注意してください。

---

## トラブルシューティング

### ポートの問題

Cloud Runは環境変数 `$PORT` でリッスンポートを指定します。Dockerfileとdocker-entrypoint.shでは `${PORT:-8080}` としてデフォルト8080を設定しています。

```bash
# Cloud Runのログを確認
gcloud run services logs read bros-nuzlocke-tracker --region asia-northeast1
```

### DB接続エラー（Supabase SSL設定）

Supabaseへの接続にはSSLが必要です。`DATABASE_URL` の末尾に `?sslmode=require` が含まれているか確認してください。

```
postgres://user:pass@host:5432/dbname?sslmode=require
```

また、`config/database.yml` の本番環境設定で `sslmode: require` が設定されていることも確認してください。

### ビルドエラー時のデバッグ

```bash
# Cloud Buildのログを確認
gcloud builds list --limit=5
gcloud builds log BUILD_ID

# ローカルでDockerビルドしてエラーを確認
docker build -t bros-nuzlocke-tracker . 2>&1 | tee build.log
```

### メモリ不足エラー

デフォルトでは512MiBのメモリを割り当てています。メモリ不足の場合は増やしてください。

```bash
gcloud run services update bros-nuzlocke-tracker \
  --region asia-northeast1 \
  --memory 1Gi
```

### コールドスタートが遅い場合

最小インスタンス数を1にすると、常に1つのインスタンスが起動状態になります（ただし無料枠を超える可能性あり）。

```bash
gcloud run services update bros-nuzlocke-tracker \
  --region asia-northeast1 \
  --min-instances 1
```

### デプロイしたのに古いバージョンが表示される

Turboのキャッシュが原因の場合があります。ブラウザのキャッシュをクリアするか、シークレットモードでアクセスしてみてください。

---

## Render.comからの移行チェックリスト

現在Render.comを使っている場合の移行手順です。

- [ ] Google Cloudプロジェクトを作成
- [ ] 必要なAPIを有効化
- [ ] Artifact Registryリポジトリを作成
- [ ] 環境変数をCloud Runに移行
- [ ] `gcloud builds submit` でデプロイ
- [ ] 動作確認（ログイン、チャレンジ作成、ポケモン追加など）
- [ ] DNSの切り替え（カスタムドメインを使っている場合）
- [ ] Render.comのサービスを停止

---

## 参考リンク

- [Cloud Run ドキュメント](https://cloud.google.com/run/docs)
- [Cloud Build ドキュメント](https://cloud.google.com/build/docs)
- [Artifact Registry ドキュメント](https://cloud.google.com/artifact-registry/docs)
- [Supabase 接続設定](https://supabase.com/docs/guides/database/connecting-to-postgres)
