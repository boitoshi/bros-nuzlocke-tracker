# frozen_string_literal: true

require 'test_helper'

class PokemonPolicyTest < ActiveSupport::TestCase
  def setup
    @user = users(:testuser)
    @other_user = users(:demouser)
    @challenge = challenges(:emerald_challenge)
    @pokemon = pokemons(:treecko)
    @other_pokemon = pokemons(:demo_pokemon)
  end

  test 'show? returns true for owner through challenge' do
    policy = PokemonPolicy.new(@user, @pokemon)
    assert policy.show?
  end

  test 'show? returns false for non-owner' do
    policy = PokemonPolicy.new(@other_user, @pokemon)
    assert_not policy.show?
  end

  test 'create? returns true for challenge owner' do
    new_pokemon = @challenge.pokemons.build
    policy = PokemonPolicy.new(@user, new_pokemon)
    assert policy.create?
  end

  test 'update? returns true for owner' do
    policy = PokemonPolicy.new(@user, @pokemon)
    assert policy.update?
  end

  test 'update? returns false for non-owner' do
    policy = PokemonPolicy.new(@other_user, @pokemon)
    assert_not policy.update?
  end

  test 'destroy? returns true for owner' do
    policy = PokemonPolicy.new(@user, @pokemon)
    assert policy.destroy?
  end

  test 'destroy? returns false for non-owner' do
    policy = PokemonPolicy.new(@other_user, @pokemon)
    assert_not policy.destroy?
  end

  test 'toggle_party? returns true for owner' do
    policy = PokemonPolicy.new(@user, @pokemon)
    assert policy.toggle_party?
  end

  test 'mark_as_dead? returns true for owner' do
    policy = PokemonPolicy.new(@user, @pokemon)
    assert policy.mark_as_dead?
  end

  test 'Scope returns only user pokemons' do
    scope = PokemonPolicy::Scope.new(@user, Pokemon).resolve
    assert_includes scope, @pokemon
    assert_not_includes scope, @other_pokemon
  end
end
