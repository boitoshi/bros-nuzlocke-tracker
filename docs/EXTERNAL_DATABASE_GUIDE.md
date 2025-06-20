# 🌐 外部データベース接続ガイド (Supabase/Heroku等)

RenderのWebサービス + 外部無料データベースの組み合わせで運用する手順です。

## 🎯 推奨構成

- **Web**: Render (無料)
- **Database**: Supabase PostgreSQL (無料)

## 🚀 Supabase設定手順

### 1. Supabaseプロジェクト作成

1. [supabase.com](https://supabase.com) でアカウント作成
2. "New Project" で以下を設定：
   ```
   Project Name: bros-nuzlocke-tracker
   Database Password: (強いパスワード)
   Region: Northeast Asia (Tokyo)
   ```

### 2. データベース情報取得

**Settings → Database** で以下をコピー：
```
Host: db.xxx.supabase.co
Database name: postgres  
Username: postgres
Password: (設定したパスワード)
Port: 5432
```

### 3. CONNECTION_STRING作成

以下の形式で作成：
```
postgresql://postgres:PASSWORD@db.xxx.supabase.co:5432/postgres?sslmode=require
```

例：
```
postgresql://postgres:mypassword123@db.abcdefghijk.supabase.co:5432/postgres?sslmode=require
```

## ⚙️ Render環境変数設定

**bros-nuzlocke-tracker-web** サービスの Environment タブで設定：

```
Key: DATABASE_URL
Value: postgresql://postgres:PASSWORD@db.xxx.supabase.co:5432/postgres?sslmode=require

Key: RAILS_MASTER_KEY
Value: (config/master.keyの内容)
```

## 🔄 デプロイ手順

1. **Renderの不要なデータベースサービス削除**：
   - `bros-nuzlocke-tracker-db` を削除（有料なので）

2. **修正をプッシュ**：
   ```bash
   git add .
   git commit -m "Switch to external database (Supabase)"
   git push origin main
   ```

3. **Renderで環境変数設定**：
   - DATABASE_URL
   - RAILS_MASTER_KEY

4. **Manual Deploy実行**

## 🎉 他の無料データベース選択肢

### Heroku Postgres
```
DATABASE_URL: postgres://username:password@hostname:port/database
```

### Railway
```  
DATABASE_URL: postgresql://username:password@hostname:port/database
```

### PlanetScale (MySQL)
```ruby
# Gemfileに追加
gem 'mysql2'

# database.yml
production:
  adapter: mysql2
  url: <%= ENV["DATABASE_URL"] %>
  sslmode: required
```

## 🔧 トラブルシューティング

### SSL接続エラー
database.ymlに以下を追加：
```yaml
sslmode: require
```

### 接続タイムアウト
```yaml
connect_timeout: 30
read_timeout: 30  
write_timeout: 30
```

### マイグレーション実行
初回デプロイ後：
```bash
# Renderのログでマイグレーション実行確認
# または手動で実行：
./bin/rails db:migrate RAILS_ENV=production
```

## 💡 コスト比較

| サービス | Web | Database | 合計 |
|----------|-----|----------|------|
| Render only | 無料 | $7/月 | $7/月 |
| **Render + Supabase** | 無料 | 無料 | 無料✨ |
| Heroku | 無料 | 無料 | 無料✨ |

---
これで無料でフル機能のアプリが運用できるよ！🎊
