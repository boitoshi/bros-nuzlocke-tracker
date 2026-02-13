# 🗄️ Supabase 総合ガイド

このガイドでは、Bros Nuzlocke TrackerアプリのSupabaseデータベース設定から運用までを一元的に解説します。

## 📚 目次

1. [クイックスタート](#クイックスタート)
2. [セットアップチェックリスト](#セットアップチェックリスト)
3. [詳細セットアップ手順](#詳細セットアップ手順)
4. [外部DB接続ガイド](#外部db接続ガイド)
5. [Row Level Security (RLS)](#row-level-security-rls)
6. [パフォーマンス最適化](#パフォーマンス最適化)
7. [トラブルシューティング](#トラブルシューティング)
8. [参考リンク](#参考リンク)

---

## 🚀 クイックスタート

最短ルートでSupabaseを使い始めるための手順です。

### 1. Supabaseプロジェクトの準備

1. [Supabase](https://supabase.com/) にアクセス
2. 新しいプロジェクトを作成
3. Database URLをコピー

### 2. 環境変数の設定

`.env` ファイルを作成して以下を設定：

```bash
# .env ファイル
DATABASE_URL=postgresql://postgres:[パスワード]@[プロジェクトURL].supabase.co:5432/postgres
SECRET_KEY_BASE=rails_secret_key_generate_で生成
```

### 3. セットアップ実行

```bash
# セットアップ実行
bin/rails db:create db:migrate db:seed

# サーバー起動
bin/rails server
```

### 4. 完了確認

- [ ] `.env`ファイル作成
- [ ] `DATABASE_URL`設定
- [ ] マイグレーション成功
- [ ] サーバー起動成功
- [ ] ブラウザアクセス成功

### 必要なGem

- `pg` - PostgreSQL接続
- `dotenv-rails` - 環境変数管理

これらは`bundle install`で自動インストールされます。

---

## ✅ セットアップチェックリスト

30分で完了するSupabase設定の全手順チェックリストです。

### Phase 1: Supabaseプロジェクト作成（5分）

- [ ] [supabase.com](https://supabase.com) でアカウント作成
- [ ] 新しいプロジェクト作成：
  ```
  Project name: bros-nuzlocke-tracker
  Database Password: [強力なパスワード]
  Region: Northeast Asia (Tokyo)
  Plan: Free
  ```
- [ ] プロジェクト作成完了まで待機（2-3分）

### Phase 2: 接続情報取得（5分）

- [ ] **Settings** → **Database** を開く
- [ ] Connection Stringをコピー：
  ```
  postgresql://postgres:[パスワード]@db.xxxxxxxx.supabase.co:5432/postgres
  ```
- [ ] この情報を安全な場所に保存

### Phase 3: Render環境変数設定（10分）

#### Renderの有料DB削除（必要に応じて）
- [ ] Dashboard → Services → bros-nuzlocke-tracker-db → Delete

#### 環境変数設定
- [ ] Dashboard → Services → bros-nuzlocke-tracker-web → Environment
- [ ] 以下の環境変数を設定：

```
DATABASE_URL: postgresql://postgres:[パスワード]@db.xxxxxxxx.supabase.co:5432/postgres
RAILS_MASTER_KEY: [config/master.keyの内容をここに入力]
```

### Phase 4: デプロイ＆テスト（10分）

- [ ] 修正をGitにコミット・プッシュ
- [ ] Renderの自動デプロイ完了まで待機
- [ ] サイトアクセス確認
- [ ] ユーザー登録・ログインテスト
- [ ] ポケモンデータ作成テスト

### 重要ポイント

#### ✅ 絶対に確認すること
- [ ] Database Passwordは忘れずにメモ
- [ ] Connection StringのSSL設定（自動）
- [ ] Regionは Tokyo 選択
- [ ] Free Planのまま（$0/月）

#### ⚠️ よくある間違い
- ❌ パスワードの記録忘れ
- ❌ 間違ったRegion選択
- ❌ `DATABASE_URL`の形式ミス
- ❌ `RAILS_MASTER_KEY`の設定忘れ

---

## 📋 詳細セットアップ手順

### 事前準備

#### 必要なもの
- [ ] GitHubアカウント
- [ ] Supabaseアカウント
- [ ] Renderアカウント

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

### Step 6: デプロイメント

#### 1. 設定ファイルのコミット
```bash
git add config/database.yml render.yaml
git commit -m "Configure Supabase database connection"
git push origin main
```

#### 2. Renderデプロイ確認
1. **Manual Deploy** または **Auto Deploy**
2. ログでデータベース接続成功を確認

#### 3. サイト動作確認
- ユーザー登録・ログイン
- ポケモンデータ作成・表示
- チャレンジ機能

---

## 🌐 外部DB接続ガイド

RenderのWebサービス + 外部無料データベースの組み合わせで運用する手順です。

### 推奨構成

- **Web**: Render（無料）
- **Database**: Supabase PostgreSQL（無料）

### CONNECTION_STRING作成

以下の形式で作成：
```
postgresql://postgres:PASSWORD@db.xxx.supabase.co:5432/postgres?sslmode=require
```

例：
```
postgresql://postgres:mypassword123@db.abcdefghijk.supabase.co:5432/postgres?sslmode=require
```

### Render環境変数設定

**bros-nuzlocke-tracker-web** サービスの Environment タブで設定：

```
Key: DATABASE_URL
Value: postgresql://postgres:PASSWORD@db.xxx.supabase.co:5432/postgres?sslmode=require

Key: RAILS_MASTER_KEY
Value: (config/master.keyの内容)
```

### デプロイ手順

1. **Renderの不要なデータベースサービス削除**：
   - `bros-nuzlocke-tracker-db` を削除（有料なので）

2. **修正をプッシュ**：
   ```bash
   git add .
   git commit -m "Switch to external database (Supabase)"
   git push origin main
   ```

3. **Renderで環境変数設定**：
   - `DATABASE_URL`
   - `RAILS_MASTER_KEY`

4. **Manual Deploy実行**

### 他の無料データベース選択肢

#### Heroku Postgres
```
DATABASE_URL: postgres://username:password@hostname:port/database
```

#### Railway
```
DATABASE_URL: postgresql://username:password@hostname:port/database
```

### コスト比較

| サービス | Web | Database | 合計 |
|----------|-----|----------|------|
| Render only | 無料 | $7/月 | $7/月 |
| **Render + Supabase** | 無料 | 無料 | **無料** ✨ |
| Heroku | 無料 | 無料 | **無料** ✨ |

---

## 🔐 Row Level Security (RLS)

### RLS 警告について

SupabaseがRailsアプリのテーブルに対してRLS設定を推奨することがあります。

### 対応の優先度

**🟡 中優先度（後回しOK）**
- サイトの動作には影響なし
- セキュリティのベストプラクティス
- 個人プロジェクトなら緊急性低

### RLSが必要なケース

#### ✅ 設定推奨
- 複数ユーザーでデータ共有
- API経由での直接アクセス
- Supabaseの管理画面からデータ操作

#### 🟡 設定不要
- Railsアプリ経由のみのアクセス
- 個人利用のみ
- プロトタイプ段階

### RLS設定方法

#### Step 1: Supabase SQL Editorで実行

```sql
-- 各テーブルでRLSを有効化
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.challenges ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pokemons ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.areas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.rules ENABLE ROW LEVEL SECURITY;
```

#### Step 2: ポリシー設定例

```sql
-- ユーザーは自分のデータのみアクセス可能
CREATE POLICY "Users can view own data" ON public.challenges
  FOR ALL USING (auth.uid() = user_id);

CREATE POLICY "Users can view own pokemons" ON public.pokemons
  FOR ALL USING (auth.uid() = (SELECT user_id FROM challenges WHERE id = challenge_id));

-- エリア・ルールは全ユーザー読み取り可能
CREATE POLICY "Areas are viewable by all users" ON public.areas
  FOR SELECT USING (true);

CREATE POLICY "Rules are viewable by all users" ON public.rules
  FOR SELECT USING (true);
```

### 緊急対応（Supabaseが使用を制限してきた場合）

```sql
-- 最低限の設定（全てのアクセスを許可）
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.challenges ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pokemons ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.areas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.rules ENABLE ROW LEVEL SECURITY;

-- 全アクセス許可ポリシー（一時的）
CREATE POLICY "Allow all" ON public.users FOR ALL USING (true);
CREATE POLICY "Allow all" ON public.challenges FOR ALL USING (true);
CREATE POLICY "Allow all" ON public.pokemons FOR ALL USING (true);
CREATE POLICY "Allow all" ON public.areas FOR ALL USING (true);
CREATE POLICY "Allow all" ON public.rules FOR ALL USING (true);
```

### 推奨アクション

#### 現段階でやること
1. ✅ エラーを無視してサイト完成を優先
2. ✅ Transaction poolerでの接続確立
3. ✅ 基本機能の動作確認

#### 将来的にやること
1. 🔐 RLS設定でセキュリティ強化
2. 📊 ユーザー分離ポリシー設計
3. 🛡️ API セキュリティ向上

---

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

### 使用量の監視

#### Supabaseダッシュボード
- **Settings** → **Usage** で使用量確認
- **Database**: 500MB制限
- **Auth**: 50,000ユーザー制限
- **API requests**: 500万リクエスト/月制限

#### アラート設定
1. **Settings** → **Billing**
2. Usage alertsを80%で設定推奨

### セキュリティ設定

#### API Key管理
- **Settings** → **API** でAPIキー確認
- Publicキーのみ使用（Rails側では不要）

---

## 🔧 トラブルシューティング

### SSL connection error
```
ERROR: SSL connection error
```
**解決法**: `database.yml`に`sslmode: require`が設定されているか確認

### Authentication failed
```
FATAL: password authentication failed
```
**解決法**:
1. パスワードが正しいか確認
2. 接続文字列の形式確認：
   ```
   postgresql://postgres:パスワード@ホスト:5432/postgres
   ```

### Connection timeout
```
Timeout::Error: execution expired
```
**解決法**:
1. Region設定確認（Tokyo推奨）
2. IPアクセス制限確認
3. 5-10分待ってリトライ

### マイグレーションエラー
```bash
# マイグレーションをリセット
rails db:drop db:create db:migrate db:seed
```

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

---

## 📞 参考リンク

### 公式ドキュメント
- [Supabase Docs](https://supabase.com/docs)
- [Supabase RLS Guide](https://supabase.com/docs/guides/database/database-linter?lint=0013_rls_disabled_in_public)
- [Row Level Security Policies](https://supabase.com/docs/guides/auth/row-level-security)
- [Rails Database Configuration](https://guides.rubyonrails.org/configuring.html#configuring-a-database)

### コミュニティ
- [Supabase Discord](https://discord.supabase.com)
- [Supabase GitHub](https://github.com/supabase/supabase)

---

この設定で完全にSupabase + Renderの連携が完了！🎉
