# 🔐 Supabase RLS 設定ガイド

## ⚠️ Row Level Security (RLS) 警告について

SupabaseがRailsアプリのテーブルに対してRLS設定を推奨している状況です。

## 🎯 対応の優先度

### 🟡 **中優先度**（後回しOK）
- サイトの動作には影響なし
- セキュリティのベストプラクティス
- 個人プロジェクトなら緊急性低

## 🤔 **RLSが必要なケース**

### ✅ **設定推奨**
- 複数ユーザーでデータ共有
- API経由での直接アクセス
- Supabaseの管理画面からデータ操作

### 🟡 **設定不要**  
- Railsアプリ経由のみのアクセス
- 個人利用のみ
- プロトタイプ段階

## 🔧 **RLS設定方法（必要な場合）**

### Step 1: Supabase SQL Editorで実行

```sql
-- 各テーブルでRLSを有効化
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.challenges ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pokemons ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.areas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.rules ENABLE ROW LEVEL SECURITY;

-- システムテーブルは通常RLS不要（Rails管理）
-- ALTER TABLE public.schema_migrations ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE public.ar_internal_metadata ENABLE ROW LEVEL SECURITY;
```

### Step 2: ポリシー設定例

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

## 📋 **今回の推奨アクション**

### 🎯 **現段階でやること**
1. ✅ エラーを無視してサイト完成を優先
2. ✅ Transaction poolerでの接続確立
3. ✅ 基本機能の動作確認

### 🔮 **将来的にやること**
1. 🔐 RLS設定でセキュリティ強化
2. 📊 ユーザー分離ポリシー設計
3. 🛡️ API セキュリティ向上

## 🚨 **緊急対応が必要な場合**

もしSupabaseが使用を制限してきたら：

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

## 📚 **参考リンク**

- [Supabase RLS Guide](https://supabase.com/docs/guides/database/database-linter?lint=0013_rls_disabled_in_public)
- [Row Level Security Policies](https://supabase.com/docs/guides/auth/row-level-security)

---

**おねえちゃんのアドバイス**: 今はサイト動作を優先して、RLSは後回しでOK！💖
