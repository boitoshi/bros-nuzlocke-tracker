# 🗄️ Supabase セットアップガイド

## 1. Supabaseプロジェクトの準備

1. [Supabase](https://supabase.com/) にアクセス
2. 新しいプロジェクトを作成
3. Database URLをコピー

## 2. 環境変数の設定

`.env` ファイルを作成して以下を設定：

```bash
# .env ファイル
DATABASE_URL=postgresql://postgres:[パスワード]@[プロジェクトURL].supabase.co:5432/postgres
SECRET_KEY_BASE=rails_secret_key_generate_で生成
```

## 3. セットアップ実行

```bash
# 実行権限を付与
chmod +x fix_database.sh

# セットアップ実行
./fix_database.sh

# サーバー起動
rails server
```

## 4. トラブルシューティング

### データベース接続エラーの場合

1. DATABASE_URLが正しく設定されているか確認
2. Supabaseプロジェクトが起動しているか確認
3. パスワードが正しいか確認

### マイグレーションエラーの場合

```bash
# マイグレーションをリセット
rails db:drop db:create db:migrate db:seed
```

## 5. 必要なGem

- `pg` - PostgreSQL接続
- `dotenv-rails` - 環境変数管理

これらは自動でインストールされます。

## 🎯 完了確認

- [ ] .envファイル作成
- [ ] DATABASE_URL設定
- [ ] マイグレーション成功
- [ ] サーバー起動成功
- [ ] ブラウザアクセス成功
