# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# 🔑 検証用管理者ユーザー作成
admin_email = "admin@bros-nuzlocke-tracker.com"
admin_password = "AdminPass123!"

admin_user = User.find_or_create_by(email: admin_email) do |user|
  user.password = admin_password
  user.password_confirmation = admin_password
end

puts "🔑 検証用管理者アカウント作成完了!"
puts "Email: #{admin_email}"
puts "Password: #{admin_password}"

# 👤 テスト用一般ユーザー
test_email = "test@example.com"
test_password = "TestPass123!"

test_user = User.find_or_create_by(email: test_email) do |user|
  user.password = test_password
  user.password_confirmation = test_password
end

puts "👤 テスト用一般ユーザー作成完了!"
puts "Email: #{test_email}"
puts "Password: #{test_password}"

# 🎮 サンプルデータ作成
if admin_user.challenges.empty?
  challenge = admin_user.challenges.create!(
    name: "サンプルナズロック",
    game: "ポケモンエメラルド", 
    status: "in_progress"
  )
  
  puts "🎮 サンプルチャレンジ作成完了!"
end

# 🌍 エリアデータの作成
areas_data = [
  "ミシロタウン", "コトキタウン", "トウカシティ", "カナズミシティ",
  "ムロタウン", "カイナシティ", "キンセツシティ", "シダケタウン",
  "ハジツゲタウン", "フエンタウン", "ヒワマキシティ", "ミナモシティ",
  "トクサネシティ", "ルネシティ", "サイユウシティ"
]

areas_data.each do |area_name|
  Area.find_or_create_by(name: area_name)
end

puts "🗺️ エリアデータ作成完了! (#{areas_data.length}箇所)"

# 📏 ルールデータの作成  
rules_data = [
  "各エリアで最初に出会ったポケモンのみ捕獲可能",
  "ポケモンが気絶したら永久にボックス送り",
  "すべてのポケモンにニックネームをつける",
  "重複したポケモンは捕獲しない",
  "レベル制限: ジムリーダーのエースレベル+2まで"
]

rules_data.each do |rule_description|
  Rule.find_or_create_by(description: rule_description)
end

puts "📏 ルールデータ作成完了! (#{rules_data.length}個)"
puts "🎉 シードデータ作成完了!"
