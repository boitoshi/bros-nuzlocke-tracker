class ChallengesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_challenge, only: [ :show, :edit, :update, :destroy ]

  def index
    @challenges = current_user.challenges.recent.includes(:user)
    @active_challenges = @challenges.in_progress
    @completed_challenges = @challenges.completed
    @failed_challenges = @challenges.failed
  end

  def show
  end

  def new
    @challenge = current_user.challenges.build
  end

  def create
    @challenge = current_user.challenges.build(challenge_params)
    @challenge.started_at = Time.current
    @challenge.status = :in_progress

    if @challenge.save
      redirect_to @challenge, notice: "チャレンジが正常に作成されました！ 🎉"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @challenge.update(challenge_params)
      redirect_to @challenge, notice: "チャレンジが正常に更新されました！"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @challenge.destroy
    redirect_to challenges_path, notice: "チャレンジが削除されました。"
  end

  private

  def set_challenge
    @challenge = current_user.challenges.find(params[:id])
  end

  def challenge_params
    params.require(:challenge).permit(:name, :game_title, :status, :completed_at)
  end
end
