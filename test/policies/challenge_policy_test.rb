# frozen_string_literal: true

require 'test_helper'

class ChallengePolicyTest < ActiveSupport::TestCase
  def setup
    @user = users(:testuser)
    @other_user = users(:demouser)
    @challenge = challenges(:emerald_challenge)
    @other_challenge = challenges(:demo_challenge)
  end

  test 'index? returns true for any logged in user' do
    policy = ChallengePolicy.new(@user, Challenge)
    assert policy.index?
  end

  test 'show? returns true for owner' do
    policy = ChallengePolicy.new(@user, @challenge)
    assert policy.show?
  end

  test 'show? returns false for non-owner' do
    policy = ChallengePolicy.new(@other_user, @challenge)
    assert_not policy.show?
  end

  test 'create? returns true for logged in user' do
    new_challenge = Challenge.new
    policy = ChallengePolicy.new(@user, new_challenge)
    assert policy.create?
  end

  test 'update? returns true for owner' do
    policy = ChallengePolicy.new(@user, @challenge)
    assert policy.update?
  end

  test 'update? returns false for non-owner' do
    policy = ChallengePolicy.new(@other_user, @challenge)
    assert_not policy.update?
  end

  test 'destroy? returns true for owner' do
    policy = ChallengePolicy.new(@user, @challenge)
    assert policy.destroy?
  end

  test 'destroy? returns false for non-owner' do
    policy = ChallengePolicy.new(@other_user, @challenge)
    assert_not policy.destroy?
  end

  test 'Scope returns only user challenges' do
    scope = ChallengePolicy::Scope.new(@user, Challenge).resolve
    assert_includes scope, @challenge
    assert_not_includes scope, @other_challenge
  end
end
