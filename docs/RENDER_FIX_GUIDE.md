# 🚨 Render Docker エラー解決ガイド

## 問題
```
error: failed to solve: failed to read dockerfile: open Dockerfile: no such file or directory
```

## 原因
Renderがまだ古い設定でDockerfileを探そうとしているため。
私たちがシンプル化でDockerfileを削除したので、Native Buildに変更する必要がある。

## 解決手順

### Step 1: render.yaml更新（完了済み）
✅ `runtime: ruby` を明示的に指定
✅ `yarn install` をbuildCommandに追加

### Step 2: Renderダッシュボードで設定確認

1. **Renderダッシュボード**にアクセス
   https://dashboard.render.com/

2. **bros-nuzlocke-tracker-web**サービスを選択

3. **Settings**タブに移動

4. **Build & Deploy**セクションで以下を確認・変更：
   
   ```
   Build Command:
   bundle install && yarn install && ./bin/rails assets:precompile && ./bin/rails db:prepare
   
   Start Command:
   ./bin/rails server -p $PORT -e $RAILS_ENV
   
   Environment: Ruby (NOT Docker)
   ```

5. **Auto-Deploy**が有効になっていることを確認

### Step 3: 手動デプロイ実行

1. **Manual Deploy**ボタンをクリック
2. **Deploy latest commit**を選択
3. ビルドログを監視

### Step 4: 設定が正しく適用されない場合

もしまだDockerエラーが出る場合：

1. **Settings** → **Build & Deploy**
2. **Docker**の設定がOFFになっているか確認
3. **Native Environment**が**Ruby**に設定されているか確認
4. 必要に応じて**Clear Build Cache**を実行

### Step 5: 緊急時の対処法

どうしてもうまくいかない場合は、一時的にダミーのDockerfileを作成：

```dockerfile
# 一時的なダミーDockerfile
FROM ruby:3.3.4-slim
WORKDIR /app
COPY . .
RUN bundle install
CMD ["rails", "server", "-p", "3000"]
```

ただし、これは最後の手段。基本的にはNative Buildを使用する。

## 確認方法

デプロイ成功後：
- [ ] サイトにアクセスできる
- [ ] ログインページが表示される
- [ ] データベース接続エラーがない
- [ ] アセット（CSS/JS）が正しく読み込まれる

## トラブルシューティング

### ビルドエラーが出る場合
```bash
# ローカルで事前確認
bundle install
yarn install
RAILS_ENV=production bin/rails assets:precompile
```

### データベースエラーが出る場合
- DATABASE_URL環境変数が正しく設定されているか確認
- PostgreSQLサービスが起動しているか確認

---

## 📱 Renderダッシュボード操作手順（詳細）

### 1. 設定変更画面への到達方法
```
dashboard.render.com 
→ bros-nuzlocke-tracker-web (サービス選択)
→ Settings (上部タブ)
→ Build & Deploy (左サイドバー)
```

### 2. 確認すべき設定項目
```
✅ Environment: Ruby 3.x
✅ Build Command: bundle install && yarn install && ./bin/rails assets:precompile && ./bin/rails db:prepare
✅ Start Command: ./bin/rails server -p $PORT -e $RAILS_ENV
❌ Docker Enable: OFF
❌ Dockerfile Path: (空欄)
```

### 3. デプロイログの確認方法
```
サービス画面 → Events タブ → 最新のデプロイログをクリック
```

成功時のログ例：
```
==> Build successful 🎉
==> Deploying...
==> Deploy successful 🎉
==> Your service is live at https://xxx.onrender.com
```

これで解決するはず！💪✨
