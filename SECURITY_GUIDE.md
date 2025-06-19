# 🔐 セキュリティガイド

## ⚠️ 重要：機密情報の取り扱い

### 🚨 **絶対にGitにコミットしてはいけないもの**

```
❌ config/master.key の内容
❌ 実際のパスワード
❌ API キー
❌ データベース接続文字列
❌ SECRET_KEY_BASE の値
```

### ✅ **安全な方法**

#### 1. 環境変数での管理
```bash
# ローカル開発
export RAILS_MASTER_KEY="新しく生成された値"
export DATABASE_URL="実際の接続文字列"
```

#### 2. Renderでの設定
```
Environment Variables:
- RAILS_MASTER_KEY: [config/master.keyから取得]
- DATABASE_URL: [Supabaseから取得]
- SECRET_KEY_BASE: [自動生成]
```

#### 3. ドキュメントでの記載方法
```markdown
❌ 実際の値を記載
RAILS_MASTER_KEY: 30257a5ea2b89e4d602220f18e1fa5d8

✅ プレースホルダーを使用
RAILS_MASTER_KEY: [config/master.keyの内容]
```

## 🔄 **漏洩時の対応手順**

### 1. 新しいキーの生成
```bash
# 新しいマスターキー生成
rails secret

# master.keyファイル更新
echo "新しいキー" > config/master.key
```

### 2. 本番環境の更新
1. Renderの環境変数を新しい値に更新
2. Manual Deploy実行
3. 動作確認

### 3. GitHubでの履歴クリーンアップ（必要に応じて）
```bash
# 機密情報を含むコミットを履歴から削除
git filter-branch --force --index-filter \
  'git rm --cached --ignore-unmatch ファイル名' \
  --prune-empty --tag-name-filter cat -- --all
```

## 📋 **セキュリティチェックリスト**

### 開発時
- [ ] `.gitignore` にmaster.keyが含まれている
- [ ] 実際の値をドキュメントに記載していない
- [ ] 環境変数でのみ機密情報を管理
- [ ] プレースホルダーを適切に使用

### デプロイ時  
- [ ] 本番環境の環境変数が正しく設定
- [ ] ローカルと本番で異なるキーを使用
- [ ] SSL接続が有効
- [ ] アクセスログに機密情報が含まれていない

### 定期確認
- [ ] 不要なアクセス権限の削除
- [ ] パスワードの定期変更
- [ ] ログファイルの機密情報チェック
- [ ] GitHubのSecurityタブ確認

## 🛠️ **自動セキュリティチェック**

### Git pre-commit hook
```bash
#!/bin/sh
# .git/hooks/pre-commit

# 機密情報のパターンをチェック
if git diff --cached --name-only | xargs grep -l "master\.key\|password.*=" 2>/dev/null; then
    echo "❌ 機密情報が含まれている可能性があります"
    exit 1
fi
```

### GitHub Secrets scanning
GitHubが自動で機密情報を検出・通知してくれます。

## 🔍 **ベストプラクティス**

### 1. **最小権限の原則**
必要最小限のアクセス権限のみ付与

### 2. **環境分離**
開発・ステージング・本番で異なる認証情報

### 3. **定期ローテーション**
機密情報の定期的な更新

### 4. **監査ログ**
アクセス履歴の記録・監視

---

このガイドに従ってセキュアな開発を心がけよう！🛡️
