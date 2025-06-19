# 🗄️ Render PostgreSQL接続エラー解決ガイド

## 🚨 エラー内容
```
PG::ConnectionBad: could not connect to server: No such file or directory
Is the server running locally and accepting connections on Unix domain socket "/var/run/postgresql/.s.PGSQL.5432"?
```

または

```
KeyError: key not found: "DATABASE_URL"
```

## 🔍 原因
1. DATABASE_URLが設定されていない（Unixソケット接続を試行）
2. PostgreSQLデータベースサービスが正しく起動していない
3. WebサービスとDBサービスの接続設定にミス
4. TCP接続ではなくローカルソケット接続を試行している

## ✅ 解決手順

### Step 1: Renderダッシュボードでデータベース確認

1. **Render Dashboard** → **Services**
2. **bros-nuzlocke-tracker-db** (データベースサービス) をクリック
3. **Status** が "Available" になっているか確認
4. もし "Creating" や "Failed" の場合は完了を待つ

### Step 2: 環境変数の確認

1. **bros-nuzlocke-tracker-web** (Webサービス) をクリック
2. **Environment** タブ
3. 以下の環境変数が自動設定されているか確認：
   ```
   ✅ DATABASE_URL (自動設定)
   ✅ DATABASE_HOST (自動設定)  
   ✅ DATABASE_PORT (自動設定)
   ✅ DATABASE_PASSWORD (自動設定)
   ⚠️ RAILS_MASTER_KEY (手動設定必要)
   ```

### Step 3: RAILS_MASTER_KEY の手動設定

Environment タブで **Add Environment Variable**:
```
```
Key: RAILS_MASTER_KEY
Value: [config/master.keyの内容をここに入力]
```

### Step 4: サービスの依存関係確認

render.yaml で以下が正しく設定されているか確認：
```yaml
- key: DATABASE_URL
  fromDatabase:
    name: bros-nuzlocke-tracker-db  # ←この名前が正確か
    property: connectionString
```

### Step 5: 手動デプロイ実行

1. **Manual Deploy** → **Deploy latest commit**
2. ログを監視して DATABASE_URL エラーが解消されたか確認

## 🚨 緊急時の対処法

### 方法1: データベースサービス再作成

もしデータベースサービスに問題がある場合：

1. **New** → **PostgreSQL**
2. 名前: `bros-nuzlocke-tracker-db`
3. Database: `bros_nuzlocke_tracker_production`
4. User: `bros_nuzlocke_tracker`
5. 作成完了後、Webサービスを再デプロイ

### 方法2: 環境変数手動設定

DATABASE_URLを直接設定：
```
Key: DATABASE_URL
Value: postgresql://username:password@hostname:port/database_name
```
（実際の値はデータベースサービスの Info タブで確認）

### 方法3: database.yml を簡素化

一時的に以下の設定でテスト：
```yaml
production:
  adapter: postgresql
  encoding: unicode
  pool: 5
  url: <%= ENV["DATABASE_URL"] || "postgresql://localhost/test" %>
```

## 📋 デバッグ用ログ確認

ビルドログで以下を確認：
```
✅ yarn install v1.22.22 → OK
✅ Done in 1.68s → OK
❌ KeyError: key not found: "DATABASE_URL" → この行がエラー
```

成功時のログ例：
```
==> Running build command: bundle install && yarn install && ./bin/rails assets:precompile && ./bin/rails db:prepare
==> Bundle complete! 
==> yarn install ... Done
==> Asset precompilation complete
==> Database prepared successfully
==> Build succeeded 🎉
```

## ⏰ タイミングの問題

データベースサービスとWebサービスの作成タイミング：
1. **まずデータベースサービス**を作成・完了待ち
2. **次にWebサービス**を作成
3. Webサービスがデータベースを参照できるようになる

## 🔄 最終確認

すべて設定後：
- [ ] Database service: Available
- [ ] Web service: Live  
- [ ] Environment variables: 設定済み
- [ ] Site access: 正常
- [ ] Database connection: 成功

---
これでDATABASE_URLエラーが解決するはず！💪✨
