# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# 🔑 検証用管理者ユーザー作成
admin_email = "admin@bros-nuzlocke-tracker.com"
admin_username = "admin"
admin_password = "AdminPass123!"

admin_user = User.find_or_create_by(email: admin_email) do |user|
  user.username = admin_username
  user.password = admin_password
  user.password_confirmation = admin_password
end

puts "🔑 検証用管理者アカウント作成完了!"
puts "Username: #{admin_username}"
puts "Email: #{admin_email}"
puts "Password: #{admin_password}"

# 👤 テスト用一般ユーザー
test_email = "test@example.com"
test_username = "testuser"
test_password = "TestPass123!"

test_user = User.find_or_create_by(email: test_email) do |user|
  user.username = test_username
  user.password = test_password
  user.password_confirmation = test_password
end

puts "👤 テスト用一般ユーザー作成完了!"
puts "Username: #{test_username}"
puts "Email: #{test_email}"
puts "Password: #{test_password}"

# 🎮 追加のテストユーザー（統計ダッシュボード確認用）
demo_email = "demo@example.com"
demo_username = "demouser"
demo_password = "DemoPass123!"

demo_user = User.find_or_create_by(email: demo_email) do |user|
  user.username = demo_username
  user.password = demo_password
  user.password_confirmation = demo_password
end

puts "🎮 デモユーザー作成完了!"
puts "Username: #{demo_username}"
puts "Email: #{demo_email}"
puts "Password: #{demo_password}"

# 🎮 サンプルデータ作成（デモユーザー用）
if demo_user&.persisted? && demo_user.challenges.empty?
  # サンプルチャレンジ作成
  demo_challenge = demo_user.challenges.create!(
    name: "デモンストレーション ナズロック",
    game_title: "emerald",
    description: "統計ダッシュボード確認用のサンプルデータです", 
    status: "in_progress"
  )
  
  puts "🎮 デモチャレンジ作成完了!"
  
  # サンプルポケモンと統計データを作成
  if demo_challenge.persisted?
    # サンプルエリア取得
    areas = Area.limit(10).to_a
    
    # サンプルポケモンデータ
    sample_pokemons = [
      { name: "アチャモ", species: "アチャモ", level: 25, status: "alive", is_party_member: true, area: areas[0] },
      { name: "ラルトス", species: "ラルトス", level: 18, status: "alive", is_party_member: true, area: areas[1] },
      { name: "マクノシタ", species: "マクノシタ", level: 20, status: "dead", is_party_member: false, area: areas[2] },
      { name: "エネコ", species: "エネコ", level: 15, status: "boxed", is_party_member: false, area: areas[3] },
      { name: "キャモメ", species: "キャモメ", level: 22, status: "alive", is_party_member: true, area: areas[4] },
      { name: "タマザラシ", species: "タマザラシ", level: 19, status: "alive", is_party_member: true, area: areas[5] }
    ]
    
    sample_pokemons.each do |pokemon_data|
      demo_challenge.pokemons.create!(
        name: pokemon_data[:name],
        species: pokemon_data[:species],
        level: pokemon_data[:level],
        status: pokemon_data[:status],
        is_party_member: pokemon_data[:is_party_member],
        area: pokemon_data[:area],
        caught_at: rand(30.days).seconds.ago
      )
    end
    
    # マイルストーンデータ
    demo_challenge.milestones.create!([
      { milestone_type: "gym_badge", name: "カナズミジム", description: "ツツジに勝利", completed_at: 10.days.ago },
      { milestone_type: "gym_badge", name: "ムロジム", description: "トウキに勝利", completed_at: 8.days.ago },
      { milestone_type: "gym_badge", name: "キンセツジム", description: "テッセンに勝利", completed_at: 5.days.ago }
    ])
    
    # イベントログデータ
    demo_challenge.event_logs.create!([
      { event_type: "pokemon_caught", description: "アチャモを捕獲", created_at: 20.days.ago },
      { event_type: "pokemon_caught", description: "ラルトスを捕獲", created_at: 18.days.ago },
      { event_type: "pokemon_died", description: "マクノシタが戦闘不能", created_at: 15.days.ago },
      { event_type: "gym_battle", description: "カナズミジムに挑戦", created_at: 10.days.ago },
      { event_type: "gym_battle", description: "ムロジムに挑戦", created_at: 8.days.ago }
    ])
    
    puts "📊 デモ用統計データ作成完了! (ポケモン: #{sample_pokemons.length}匹, マイルストーン: 3個, イベント: 5個)"
  end
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
