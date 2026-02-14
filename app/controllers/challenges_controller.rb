class ChallengesController < ApplicationController
  before_action :authenticate_user!, except: [:overlay]
  before_action :set_challenge, only: [ :show, :edit, :update, :destroy, :progress ]
  before_action :protect_guest_demo_data, only: [ :destroy ]

  def index
    @challenges = current_user.challenges.recent.includes(:user)
    @active_challenges = @challenges.in_progress
    @completed_challenges = @challenges.completed
    @failed_challenges = @challenges.failed
  end

  def show
    # エリア捕獲状況マップ用データ
    @areas = Area.by_game(@challenge.game_title).by_order
    @caught_by_area = @challenge.pokemons.includes(:area).group_by(&:area_id)
  end

  def new
    @challenge = current_user.challenges.build
  end

  def edit
  end

  def create
    @challenge = current_user.challenges.build(challenge_params)
    @challenge.started_at = Time.current
    @challenge.status = :in_progress

    if @challenge.save
      redirect_to challenge_pokemons_path(@challenge), notice: t("challenges.notices.created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @challenge.update(challenge_params)
      redirect_to @challenge, notice: t("challenges.notices.updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @challenge.destroy
    redirect_to challenges_path, notice: t("challenges.notices.deleted")
  end

  def progress
    @milestones = @challenge.milestones.by_order
    @badges = @milestones.select(&:gym_badge?)
    @elite_four = @milestones.select(&:elite_four?)
    @champion = @milestones.select(&:champion?)
    @story_events = @milestones.select(&:story_event?)
    @party_pokemon = @challenge.party_pokemon.includes(:area)
  end

  def overlay
    @challenge = Challenge.find(params[:id])
    @party_pokemon = @challenge.party_pokemon.includes(:area)
    @dead_pokemon = @challenge.dead_pokemon.includes(:area)
    @badges = @challenge.milestones.gym_badge.by_order
    render layout: 'overlay'
  end

  private

  def set_challenge
    @challenge = current_user.challenges.find(params[:id])
  end

  def challenge_params
    params.expect(challenge: [ :name, :game_title, :status, :completed_at ])
  end

  # ゲストユーザーのデモチャレンジ削除を防止
  def protect_guest_demo_data
    if guest_user? && @challenge.name == "デモンストレーション ナズロック"
      redirect_to challenges_path, alert: 'ゲスト体験ではデモデータの削除はできません 🔒'
    end
  end
end
