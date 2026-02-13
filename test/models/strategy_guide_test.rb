require 'test_helper'

class StrategyGuideTest < ActiveSupport::TestCase
  setup do
    @guide = strategy_guides(:one)
  end

  # === バリデーションテスト ===

  test 'タイトルが必須であること' do
    @guide.title = nil
    assert_not @guide.valid?
    assert_includes @guide.errors[:title], "can't be blank"
  end

  test 'タイトルが200文字以内であること' do
    @guide.title = 'あ' * 201
    assert_not @guide.valid?
  end

  test 'ガイドタイプが必須であること' do
    @guide.guide_type = nil
    assert_not @guide.valid?
  end

  test 'ゲームタイトルが必須であること' do
    @guide.game_title = nil
    assert_not @guide.valid?
  end

  test 'コンテンツが必須であること' do
    @guide.content = nil
    assert_not @guide.valid?
  end

  test 'コンテンツが10文字以上であること' do
    @guide.content = 'あ' * 9
    assert_not @guide.valid?
  end

  test '著者が必須であること' do
    @guide.author = nil
    assert_not @guide.valid?
  end

  test '難易度が1〜5であること' do
    @guide.difficulty = 0
    assert_not @guide.valid?

    @guide.difficulty = 6
    assert_not @guide.valid?
  end

  # === enumテスト ===

  test 'ガイドタイプのenum値が正しいこと' do
    assert_equal 0, StrategyGuide.guide_types['general']
    assert_equal 3, StrategyGuide.guide_types['nuzlocke_tips']
  end

  # === 関連テスト ===

  test 'ボスバトルに任意で属すること' do
    assert_respond_to @guide, :target_boss
  end

  # === スコープテスト ===

  test 'publishedスコープが公開ガイドのみ返すこと' do
    StrategyGuide.published.each do |g|
      assert g.is_public
    end
  end

  test 'by_gameスコープがゲーム別にフィルタすること' do
    guides = StrategyGuide.by_game('red')
    guides.each do |g|
      assert_equal 'red', g.game_title
    end
  end

  # === メソッドテスト ===

  test 'guide_type_displayが日本語を返すこと' do
    @guide.guide_type = 'general'
    assert_equal '一般攻略', @guide.guide_type_display

    @guide.guide_type = 'nuzlocke_tips'
    assert_equal 'ナズロック攻略', @guide.guide_type_display
  end

  test 'guide_type_iconが絵文字を返すこと' do
    @guide.guide_type = 'general'
    assert_equal '📝', @guide.guide_type_icon
  end

  test 'target_boss_nameが名前を返すこと' do
    assert_kind_of String, @guide.target_boss_name
  end
end
