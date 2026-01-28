# frozen_string_literal: true

require 'test_helper'

class ChallengeTest < ActiveSupport::TestCase
  def setup
    @user = users(:testuser)
    @challenge = challenges(:emerald_challenge)
  end

  test 'should be valid with valid attributes' do
    assert @challenge.valid?
  end

  test 'should require name' do
    @challenge.name = nil
    assert_not @challenge.valid?
    assert_includes @challenge.errors[:name], "can't be blank"
  end

  test 'should require game_title' do
    @challenge.game_title = nil
    assert_not @challenge.valid?
    assert_includes @challenge.errors[:game_title], "can't be blank"
  end

  test 'should validate game_title inclusion' do
    @challenge.game_title = 'invalid_game'
    assert_not @challenge.valid?
    assert_includes @challenge.errors[:game_title], 'is not included in the list'
  end

  test 'should require started_at' do
    @challenge.started_at = nil
    assert_not @challenge.valid?
    assert_includes @challenge.errors[:started_at], "can't be blank"
  end

  test 'should have default status of in_progress when created' do
    new_challenge = @user.challenges.new(
      name: 'Test Challenge',
      game_title: 'red',
      started_at: Time.current,
      status: :in_progress
    )
    new_challenge.save
    assert new_challenge.in_progress?
  end

  test 'should calculate duration_in_days' do
    @challenge.started_at = 5.days.ago
    @challenge.completed_at = Time.current
    assert_equal 5, @challenge.duration_in_days
  end

  test 'should return game_title_display' do
    @challenge.game_title = 'emerald'
    assert_equal 'ポケットモンスター エメラルド', @challenge.game_title_display
  end

  test 'should belong to user' do
    assert_equal @user, @challenge.user
  end

  test 'should have many pokemons' do
    assert_respond_to @challenge, :pokemons
  end

  test 'should destroy dependent pokemons' do
    pokemon = @challenge.pokemons.create(
      nickname: 'Test',
      species: 'Pikachu',
      level: 5,
      status: :alive,
      caught_at: Time.current
    )
    assert_difference 'Pokemon.count', -1 do
      @challenge.destroy
    end
  end
end
