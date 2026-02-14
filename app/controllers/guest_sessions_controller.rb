class GuestSessionsController < ApplicationController
  # ゲストログイン機能 - デバッグ・デモ用 🎮

  def create
    # デモユーザーとしてログイン
    demo_user = User.find_by(username: 'demouser')

    if demo_user
      sign_in(demo_user)
      setup_demo_data(demo_user)
      redirect_to root_path, notice: '🎮 ゲストユーザーとしてログインしました！デモ機能をお楽しみください ✨'
    else
      # デモユーザーが存在しない場合は作成
      begin
        demo_user = create_demo_user
        sign_in(demo_user)
        setup_demo_data(demo_user)
        redirect_to root_path, notice: '🎮 ゲストユーザーを作成してログインしました！デモ機能をお楽しみください ✨'
      rescue StandardError => e
        Rails.logger.error "Failed to create demo user: #{e.message}"
        redirect_to root_path, alert: '❌ ゲストログインに失敗しました。しばらく時間をおいて再度お試しください。'
      end
    end
  end

  def destroy
    if user_signed_in? && current_user.username == 'demouser'
      sign_out(current_user)
      redirect_to root_path, notice: '👋 ゲストセッションを終了しました。'
    else
      redirect_to root_path
    end
  end

  private

  def create_demo_user
    User.create!(
      username: 'demouser',
      email: 'demo@example.com',
      password: 'DemoPass123!',
      password_confirmation: 'DemoPass123!'
    )
  end

  # デモデータが存在しなければ自動セットアップ
  def setup_demo_data(user)
    return if user.challenges.any?

    # エリアデータ（emerald用15箇所）がなければ先に作成
    ensure_emerald_areas!

    # デモチャレンジ作成
    demo_challenge = user.challenges.create!(
      name: "デモンストレーション ナズロック",
      game_title: "emerald",
      status: "in_progress",
      started_at: 30.days.ago
    )

    # エリアを取得
    areas = Area.where(game_title: "emerald").order(:order_index).to_a

    # サンプルポケモン6匹
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

    # マイルストーン3個
    demo_challenge.milestones.create!([
      { milestone_type: "gym_badge", name: "カナズミジム", description: "ツツジに勝利", completed_at: 10.days.ago, order_index: 1 },
      { milestone_type: "gym_badge", name: "ムロジム", description: "トウキに勝利", completed_at: 8.days.ago, order_index: 2 },
      { milestone_type: "gym_badge", name: "キンセツジム", description: "テッセンに勝利", completed_at: 5.days.ago, order_index: 3 }
    ])

    # イベントログ5個
    demo_challenge.event_logs.create!([
      { event_type: "pokemon_caught", title: "アチャモを捕獲！", description: "最初のパートナー", occurred_at: 20.days.ago },
      { event_type: "pokemon_caught", title: "ラルトスを捕獲！", description: "ルート102で遭遇", occurred_at: 18.days.ago },
      { event_type: "pokemon_died", title: "マクノシタが戦闘不能...", description: "カナズミジムで倒された", occurred_at: 15.days.ago, importance: 5 },
      { event_type: "gym_battle", title: "カナズミジムに挑戦", description: "ツツジに勝利！", occurred_at: 10.days.ago, importance: 4 },
      { event_type: "gym_battle", title: "ムロジムに挑戦", description: "トウキに勝利！", occurred_at: 8.days.ago, importance: 4 }
    ])

    Rails.logger.info "🎮 デモデータを自動セットアップしました（チャレンジ1, ポケモン6, マイルストーン3, イベント5）"
  rescue StandardError => e
    Rails.logger.error "デモデータのセットアップに失敗: #{e.message}"
  end

  # エメラルド用エリアデータの確保
  def ensure_emerald_areas!
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
  end
end
