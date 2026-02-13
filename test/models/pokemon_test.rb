require 'test_helper'

class PokemonTest < ActiveSupport::TestCase
  setup do
    @pokemon = pokemons(:one)
    @challenge = challenges(:one)
    @area = areas(:one)
  end

  # === バリデーションテスト ===

  test 'ニックネームが必須であること' do
    @pokemon.nickname = nil
    assert_not @pokemon.valid?
    assert_includes @pokemon.errors[:nickname], "can't be blank"
  end

  test 'ニックネームが20文字以内であること' do
    @pokemon.nickname = 'あ' * 21
    assert_not @pokemon.valid?
  end

  test '種族名が必須であること' do
    @pokemon.species = nil
    assert_not @pokemon.valid?
    assert_includes @pokemon.errors[:species], "can't be blank"
  end

  test 'レベルが1〜100であること' do
    @pokemon.level = 0
    assert_not @pokemon.valid?

    @pokemon.level = 101
    assert_not @pokemon.valid?

    @pokemon.level = 50
    assert @pokemon.valid?
  end

  test '捕獲日が必須であること' do
    @pokemon.caught_at = nil
    assert_not @pokemon.valid?
    assert_includes @pokemon.errors[:caught_at], "can't be blank"
  end

  test '個体値が0〜31であること' do
    @pokemon.hp_iv = -1
    assert_not @pokemon.valid?

    @pokemon.hp_iv = 32
    assert_not @pokemon.valid?

    @pokemon.hp_iv = 15
    assert @pokemon.valid?
  end

  test '努力値が0〜252であること' do
    @pokemon.hp_ev = -1
    assert_not @pokemon.valid?

    @pokemon.hp_ev = 253
    assert_not @pokemon.valid?

    @pokemon.hp_ev = 100
    assert @pokemon.valid?
  end

  test '努力値の合計が510以内であること' do
    @pokemon.hp_ev = 252
    @pokemon.attack_ev = 252
    @pokemon.defense_ev = 10
    @pokemon.special_attack_ev = 0
    @pokemon.special_defense_ev = 0
    @pokemon.speed_ev = 0
    assert_not @pokemon.valid?
  end

  test '有効な性格のみ受け入れること' do
    @pokemon.nature = '無効な性格'
    assert_not @pokemon.valid?

    @pokemon.nature = 'がんばりや'
    assert @pokemon.valid?
  end

  test '性格が空でも有効であること' do
    @pokemon.nature = nil
    assert @pokemon.valid?
  end

  # === enumテスト ===

  test 'ステータスのenum値が正しいこと' do
    assert_equal 0, Pokemon.statuses['alive']
    assert_equal 1, Pokemon.statuses['dead']
    assert_equal 2, Pokemon.statuses['boxed']
  end

  test 'ロールのenum値が正しいこと' do
    assert_equal 0, Pokemon.roles['physical_attacker']
    assert_equal 1, Pokemon.roles['special_attacker']
  end

  # === 関連テスト ===

  test 'チャレンジに属すること' do
    assert_respond_to @pokemon, :challenge
    assert_equal @challenge, @pokemon.challenge
  end

  test 'エリアに属すること' do
    assert_respond_to @pokemon, :area
  end

  # === スコープテスト ===

  test 'party_membersがパーティメンバーを返すこと' do
    party = Pokemon.party_members
    party.each do |p|
      assert p.in_party, "パーティメンバーのin_partyはtrueのはず"
    end
  end

  test 'alive_pokemonが生存ポケモンを返すこと' do
    alive = Pokemon.alive_pokemon
    alive.each do |p|
      assert_equal 'alive', p.status
    end
  end

  # === メソッドテスト ===

  test 'status_displayが日本語を返すこと' do
    @pokemon.status = 'alive'
    assert_equal '生存', @pokemon.status_display

    @pokemon.status = 'dead'
    assert_equal '死亡', @pokemon.status_display

    @pokemon.status = 'boxed'
    assert_equal 'ボックス', @pokemon.status_display
  end

  test 'status_badge_classがBootstrapクラスを返すこと' do
    @pokemon.status = 'alive'
    assert_equal 'bg-success', @pokemon.status_badge_class

    @pokemon.status = 'dead'
    assert_equal 'bg-danger', @pokemon.status_badge_class
  end
end
