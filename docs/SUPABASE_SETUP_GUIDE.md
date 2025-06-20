# 🗄️ Supabase設定完全ガイド

## 🎯 概要
このガイドでは、Renderアプリ用のSupabaseデータベース設定を詳しく解説します。

## 📋 事前準備

### 必要なもの
- [ ] GitHubアカウント
- [ ] Supabaseアカウント
- [ ] Renderアカウント

## 🚀 Step-by-Step設定手順

### Step 1: Supabaseプロジェクト作成

1. **[supabase.com](https://supabase.com)** にアクセス
2. **"Start your project"** をクリック
3. **GitHub連携**でサインアップ（推奨）

### Step 2: 新しいプロジェクト設定

```
Organization: Personal
Project name: bros-nuzlocke-tracker
Database Password: 強力なパスワード（メモ必須！）
Region: Northeast Asia (Tokyo)
Pricing Plan: Free
```

**重要**: Database Passwordは絶対に忘れないように！📝

### Step 3: 接続情報の取得

プロジェクト作成完了後（約2-3分）：

1. **Settings** → **Database** をクリック
2. 以下の情報をメモ：

#### Connection Parameters
```
Host: db.xxxxxxxxxxxxxxxx.supabase.co
Database name: postgres
Username: postgres
Password: [Step2で設定したパスワード]
Port: 5432
```

#### Connection String（重要！）
```
postgresql://postgres:[パスワード]@db.xxxxxxxxxxxxxxxx.supabase.co:5432/postgres
```

### Step 4: Renderでの環境変数設定

#### 4-1. Renderダッシュボードにアクセス
1. [render.com](https://render.com) にログイン
2. **Services** → **bros-nuzlocke-tracker-web** を選択

#### 4-2. 環境変数の設定
**Environment** タブで以下を設定：

```
Key: DATABASE_URL
Value: postgresql://postgres:[パスワード]@db.xxxxxxxxxxxxxxxx.supabase.co:5432/postgres

Key: RAILS_MASTER_KEY
Value: [ローカルのconfig/master.keyの内容]
```

**RAILS_MASTER_KEYの確認方法**:
```bash
cd /workspaces/bros-nuzlocke-tracker
cat config/master.key
```

#### 4-3. 追加の環境変数（オプション）
```
Key: RAILS_ENV
Value: production

Key: RAILS_SERVE_STATIC_FILES  
Value: true

Key: RAILS_LOG_TO_STDOUT
Value: true
```

### Step 5: データベースの初期化

#### 5-1. テーブル作成
Renderデプロイ時に自動で実行されますが、手動確認も可能：

```bash
# ローカルで確認
RAILS_ENV=production DATABASE_URL="[Supabaseの接続文字列]" rails db:create db:migrate
```

#### 5-2. Supabaseダッシュボードでの確認
1. **Table Editor** で作成されたテーブルを確認
2. 以下のテーブルが作成されているはず：
   - `users`
   - `challenges`  
   - `pokemons`
   - `areas`
   - `rules`

## 🔧 トラブルシューティング

### よくあるエラー

#### ❌ SSL connection error
```
ERROR: SSL connection error
```

**解決法**: database.ymlに`sslmode: require`が設定されているか確認

#### ❌ Authentication failed
```
FATAL: password authentication failed
```

**解決法**: 
1. パスワードが正しいか確認
2. 接続文字列の形式確認：
   ```
   postgresql://postgres:パスワード@ホスト:5432/postgres
   ```

#### ❌ Connection timeout
```
Timeout::Error: execution expired
```

**解決法**:
1. Region設定確認（Tokyo推奨）
2. IPアクセス制限確認

### デバッグ用コマンド

#### 接続テスト
```bash
# ローカルでの接続テスト
psql "postgresql://postgres:パスワード@db.xxxxxxxx.supabase.co:5432/postgres"
```

#### Rails接続確認
```bash
# database.yml設定確認
rails db:version
```

## 📊 パフォーマンス最適化

### Connection Pool設定
```yaml
# config/database.yml
production:
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  # Supabase Free Planは最大60接続
```

### タイムアウト設定
```yaml
connect_timeout: 30  # 接続タイムアウト
read_timeout: 30     # 読み取りタイムアウト  
write_timeout: 30    # 書き込みタイムアウト
```

## 📈 使用量の監視

### Supabaseダッシュボード
- **Settings** → **Usage** で使用量確認
- **Database**: 500MB制限
- **Auth**: 50,000ユーザー制限
- **API requests**: 500万リクエスト/月制限

### アラート設定
1. **Settings** → **Billing**  
2. Usage alertsを80%で設定推奨

## 🔐 セキュリティ設定

### Row Level Security (RLS)
Supabaseの強力なセキュリティ機能：

```sql
-- 例: ユーザー自身のデータのみアクセス可能
CREATE POLICY "Users can view own data" ON challenges
  FOR SELECT USING (auth.uid() = user_id);
```

### API Key管理
- **Settings** → **API** でAPIキー確認
- Publicキーのみ使用（Rails側では不要）

## 🚀 デプロイメント

### 1. 設定ファイルのコミット
```bash
git add config/database.yml render.yaml
git commit -m "Configure Supabase database connection"
git push origin main
```

### 2. Renderデプロイ確認
1. **Manual Deploy** または **Auto Deploy**
2. ログでデータベース接続成功を確認

### 3. サイト動作確認
- ユーザー登録・ログイン
- ポケモンデータ作成・表示
- チャレンジ機能

## 📞 サポート

### 公式ドキュメント
- [Supabase Docs](https://supabase.com/docs)
- [Rails Database Configuration](https://guides.rubyonrails.org/configuring.html#configuring-a-database)

### コミュニティ
- [Supabase Discord](https://discord.supabase.com)
- [Supabase GitHub](https://github.com/supabase/supabase)

---

この設定で完全にSupabase + Renderの連携が完了！🎉
