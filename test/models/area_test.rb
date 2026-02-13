require 'test_helper'

class AreaTest < ActiveSupport::TestCase
  setup do
    @area = areas(:one)
  end

  # === バリデーションテスト ===

  test '名前が必須であること' do
    @area.name = nil
    assert_not @area.valid?
    assert_includes @area.errors[:name], "can't be blank"
  end

  test '名前が100文字以内であること' do
    @area.name = 'あ' * 101
    assert_not @area.valid?
  end

  test 'エリアタイプが必須であること' do
    @area.area_type = nil
    assert_not @area.valid?
  end

  test 'ゲームタイトルが必須であること' do
    @area.game_title = nil
    assert_not @area.valid?
  end

  test 'order_indexが必須であること' do
    @area.order_index = nil
    assert_not @area.valid?
  end

  test 'order_indexが0以上であること' do
    @area.order_index = -1
    assert_not @area.valid?
  end

  # === enumテスト ===

  test 'エリアタイプのenum値が正しいこと' do
    assert_equal 0, Area.area_types['route']
    assert_equal 1, Area.area_types['city']
    assert_equal 2, Area.area_types['gym']
    assert_equal 4, Area.area_types['forest']
  end

  # === 関連テスト ===

  test 'ポケモンを複数持てること' do
    assert_respond_to @area, :pokemons
  end

  # === スコープテスト ===

  test 'by_gameスコープがゲーム別にフィルタすること' do
    areas = Area.by_game('red')
    areas.each do |a|
      assert_equal 'red', a.game_title
    end
  end

  # === メソッドテスト ===

  test 'area_type_displayが日本語を返すこと' do
    @area.area_type = 'route'
    assert_equal 'ルート', @area.area_type_display

    @area.area_type = 'gym'
    assert_equal 'ジム', @area.area_type_display
  end

  test 'area_type_iconが絵文字を返すこと' do
    @area.area_type = 'route'
    assert_equal '🛤️', @area.area_type_icon

    @area.area_type = 'forest'
    assert_equal '🌲', @area.area_type_icon
  end

  test 'display_nameがアイコン付きで表示すること' do
    @area.area_type = 'route'
    @area.name = 'ルート1'
    assert_equal '🛤️ ルート1', @area.display_name
  end
end
