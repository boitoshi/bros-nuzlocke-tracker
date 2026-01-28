# frozen_string_literal: true

class ChallengesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_challenge, only: %i[show edit update destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @challenges = policy_scope(Challenge).recent.includes(:user)
    @active_challenges = @challenges.in_progress
    @completed_challenges = @challenges.completed
    @failed_challenges = @challenges.failed
  end

  def show
    authorize @challenge
  end

  def new
    @challenge = current_user.challenges.build
    authorize @challenge
  end

  def edit
    authorize @challenge
  end

  def create
    @challenge = current_user.challenges.build(challenge_params)
    authorize @challenge
    @challenge.started_at = Time.current
    @challenge.status = :in_progress

    if @challenge.save
      redirect_to @challenge, notice: t('challenges.notices.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @challenge
    if @challenge.update(challenge_params)
      redirect_to @challenge, notice: t('challenges.notices.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @challenge
    @challenge.destroy
    redirect_to challenges_path, notice: t('challenges.notices.deleted')
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  def challenge_params
    params.expect(challenge: %i[name game_title status completed_at])
  end
end
