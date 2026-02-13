# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "🌱 シードデータの作成を開始します..."

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
puts "   Username: #{admin_username} / Email: #{admin_email}"

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
puts "   Username: #{test_username} / Email: #{test_email}"

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
puts "   Username: #{demo_username} / Email: #{demo_email}"

# 🌍 エリアデータの作成（ポケモンより先に作成する必要あり）
emerald_areas = [
  { name: "ミシロタウン", area_type: "city", game_title: "emerald", order_index: 0 },
  { name: "コトキタウン", area_type: "city", game_title: "emerald", order_index: 1 },
  { name: "ルート101", area_type: "route", game_title: "emerald", order_index: 2 },
  { name: "ルート102", area_type: "route", game_title: "emerald", order_index: 3 },
  { name: "トウカシティ", area_type: "city", game_title: "emerald", order_index: 4 },
  { name: "カナズミシティ", area_type: "city", game_title: "emerald", order_index: 5 },
  { name: "ルート104", area_type: "route", game_title: "emerald", order_index: 6 },
  { name: "トウカの森", area_type: "forest", game_title: "emerald", order_index: 7 },
  { name: "カナズミジム", area_type: "gym", game_title: "emerald", order_index: 8 },
  { name: "ムロタウン", area_type: "city", game_title: "emerald", order_index: 9 },
  { name: "ムロジム", area_type: "gym", game_title: "emerald", order_index: 10 },
  { name: "カイナシティ", area_type: "city", game_title: "emerald", order_index: 11 },
  { name: "キンセツシティ", area_type: "city", game_title: "emerald", order_index: 12 },
  { name: "キンセツジム", area_type: "gym", game_title: "emerald", order_index: 13 },
  { name: "シダケタウン", area_type: "city", game_title: "emerald", order_index: 14 }
]

emerald_areas.each do |area_data|
  Area.find_or_create_by(name: area_data[:name], game_title: area_data[:game_title]) do |area|
    area.area_type = area_data[:area_type]
    area.order_index = area_data[:order_index]
  end
end

puts "🗺️ エメラルド用エリアデータ作成完了! (#{emerald_areas.length}箇所)"

# 🎮 サンプルデータ作成（デモユーザー用）
if demo_user&.persisted? && demo_user.challenges.empty?
  # サンプルチャレンジ作成（descriptionカラムは存在しないので除外）
  demo_challenge = demo_user.challenges.create!(
    name: "デモンストレーション ナズロック",
    game_title: "emerald",
    status: "in_progress",
    started_at: 30.days.ago
  )

  puts "🎮 デモチャレンジ作成完了!"

  # サンプルポケモンと統計データを作成
  if demo_challenge.persisted?
    # エリアを取得（先に作成済み）
    areas = Area.where(game_title: "emerald").order(:order_index).to_a

    # サンプルポケモンデータ（正しいカラム名: nickname, in_party）
    sample_pokemons = [
      { nickname: "アチャモ", species: "アチャモ", level: 25, status: "alive", in_party: true, area: areas[0], primary_type: "fire" },
      { nickname: "ラルトス", species: "ラルトス", level: 18, status: "alive", in_party: true, area: areas[1], primary_type: "psychic" },
      { nickname: "マクノシタ", species: "マクノシタ", level: 20, status: "dead", in_party: false, area: areas[2], primary_type: "fighting" },
      { nickname: "エネコ", species: "エネコ", level: 15, status: "boxed", in_party: false, area: areas[3], primary_type: "normal" },
      { nickname: "キャモメ", species: "キャモメ", level: 22, status: "alive", in_party: true, area: areas[4], primary_type: "water", secondary_type: "flying" },
      { nickname: "タマザラシ", species: "タマザラシ", level: 19, status: "alive", in_party: true, area: areas[5], primary_type: "ice", secondary_type: "water" }
    ]

    sample_pokemons.each do |pokemon_data|
      demo_challenge.pokemons.create!(
        nickname: pokemon_data[:nickname],
        species: pokemon_data[:species],
        level: pokemon_data[:level],
        status: pokemon_data[:status],
        in_party: pokemon_data[:in_party],
        area: pokemon_data[:area],
        primary_type: pokemon_data[:primary_type],
        secondary_type: pokemon_data[:secondary_type],
        caught_at: rand(30.days).seconds.ago
      )
    end

    # マイルストーンデータ（order_indexは必須）
    demo_challenge.milestones.create!([
      { milestone_type: "gym_badge", name: "カナズミジム", description: "ツツジに勝利", completed_at: 10.days.ago, order_index: 1 },
      { milestone_type: "gym_badge", name: "ムロジム", description: "トウキに勝利", completed_at: 8.days.ago, order_index: 2 },
      { milestone_type: "gym_badge", name: "キンセツジム", description: "テッセンに勝利", completed_at: 5.days.ago, order_index: 3 }
    ])

    # イベントログデータ（title, occurred_atは必須）
    demo_challenge.event_logs.create!([
      { event_type: "pokemon_caught", title: "アチャモを捕獲！", description: "最初のパートナー", occurred_at: 20.days.ago },
      { event_type: "pokemon_caught", title: "ラルトスを捕獲！", description: "ルート102で遭遇", occurred_at: 18.days.ago },
      { event_type: "pokemon_died", title: "マクノシタが戦闘不能...", description: "カナズミジムで倒された", occurred_at: 15.days.ago, importance: 5 },
      { event_type: "gym_battle", title: "カナズミジムに挑戦", description: "ツツジに勝利！", occurred_at: 10.days.ago, importance: 4 },
      { event_type: "gym_battle", title: "ムロジムに挑戦", description: "トウキに勝利！", occurred_at: 8.days.ago, importance: 4 }
    ])

    puts "📊 デモ用統計データ作成完了! (ポケモン: #{sample_pokemons.length}匹, マイルストーン: 3個, イベント: 5個)"
  end
end

# ルールはチャレンジ作成時にafter_createコールバックで自動生成されるため、
# 独立したルール作成は不要（Ruleモデルはchallenge_idが必須）

# =============================================================================
# タイプ相性データ投入 ⚡
# 18タイプ × 18タイプ = 324件の相性データ
# =============================================================================
puts "タイプ相性データを投入中..."
TypeEffectiveness.seed_type_chart!
puts "✅ タイプ相性データ投入完了！（#{TypeEffectiveness.count}件）"

# =============================================================================
# ポケモン図鑑データ投入 📖
# 第1〜3世代（No.1〜No.386）= 386匹
# =============================================================================
puts "📖 ポケモン図鑑データを投入中..."

# シードデータファイルを読み込み
Dir[Rails.root.join('db/seeds/pokemon_species_gen*.rb')].sort.each do |file|
  require file
end

# 各世代のデータを結合して投入
all_pokemon_data = []
all_pokemon_data.concat(POKEMON_GEN1_DATA) if defined?(POKEMON_GEN1_DATA)
all_pokemon_data.concat(POKEMON_GEN2_DATA) if defined?(POKEMON_GEN2_DATA)
all_pokemon_data.concat(POKEMON_GEN3_DATA) if defined?(POKEMON_GEN3_DATA)

created_count = 0
skipped_count = 0

all_pokemon_data.each do |pokemon|
  species = PokemonSpecies.find_or_initialize_by(national_id: pokemon[:national_id])
  if species.new_record?
    species.assign_attributes(
      name_ja: pokemon[:name_ja],
      name_en: pokemon[:name_en],
      name_kana: pokemon[:name_kana],
      data: pokemon[:data]
    )
    species.save!
    created_count += 1
  else
    skipped_count += 1
  end
end

puts "✅ ポケモン図鑑データ投入完了！（新規: #{created_count}匹, スキップ: #{skipped_count}匹, 合計: #{PokemonSpecies.count}匹）"

puts "🎉 シードデータ作成完了!"
