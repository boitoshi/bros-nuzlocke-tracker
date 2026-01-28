# frozen_string_literal: true

require 'test_helper'

class PokemonTest < ActiveSupport::TestCase
  def setup
    @challenge = challenges(:emerald_challenge)
    @pokemon = pokemons(:treecko)
  end

  test 'should be valid with valid attributes' do
    assert @pokemon.valid?
  end

  test 'should require species' do
    @pokemon.species = nil
    assert_not @pokemon.valid?
    assert_includes @pokemon.errors[:species], "can't be blank"
  end

  test 'should require level' do
    @pokemon.level = nil
    assert_not @pokemon.valid?
    assert_includes @pokemon.errors[:level], "can't be blank"
  end

  test 'should validate level is positive' do
    @pokemon.level = 0
    assert_not @pokemon.valid?
    assert_includes @pokemon.errors[:level], 'must be greater than 0'
  end

  test 'should validate level is not greater than 100' do
    @pokemon.level = 101
    assert_not @pokemon.valid?
    assert_includes @pokemon.errors[:level], 'must be less than or equal to 100'
  end

  test 'should have default status of alive when created' do
    new_pokemon = @challenge.pokemons.new(
      species: 'Pikachu',
      level: 5,
      caught_at: Time.current,
      status: :alive,
      primary_type: 'でんき',
      role: :special_attacker,
      area: areas(:one)
    )
    new_pokemon.save
    assert new_pokemon.alive?
  end

  test 'should belong to challenge' do
    assert_equal @challenge, @pokemon.challenge
  end

  test 'display_name returns nickname and species' do
    assert_equal 'キモリ (キモリ)', @pokemon.display_name
  end

  test 'can_be_in_party? returns true for alive pokemon' do
    @pokemon.status = :alive
    assert @pokemon.can_be_in_party?
  end

  test 'can_be_in_party? returns false for dead pokemon' do
    @pokemon.status = :dead
    assert_not @pokemon.can_be_in_party?
  end

  test 'can_be_in_party? returns false for boxed pokemon' do
    @pokemon.status = :boxed
    assert_not @pokemon.can_be_in_party?
  end

  test 'should validate total EVs not exceed 510' do
    @pokemon.hp_ev = 255
    @pokemon.attack_ev = 255
    @pokemon.defense_ev = 1
    assert_not @pokemon.valid?
    assert_includes @pokemon.errors[:base].first, '努力値の合計は510を超えることはできません'
  end

  test 'should validate individual EV not exceed 252' do
    @pokemon.hp_ev = 253
    assert_not @pokemon.valid?
    assert_includes @pokemon.errors[:hp_ev], 'must be less than or equal to 252'
  end

  test 'should validate IVs are between 0 and 31' do
    @pokemon.hp_iv = 32
    assert_not @pokemon.valid?
    assert_includes @pokemon.errors[:hp_iv], 'must be less than or equal to 31'

    @pokemon.hp_iv = -1
    assert_not @pokemon.valid?
    assert_includes @pokemon.errors[:hp_iv], 'must be greater than or equal to 0'
  end
end
