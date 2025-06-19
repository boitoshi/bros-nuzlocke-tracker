class BossBattlesController < ApplicationController
  before_action :set_boss_battle, only: [:show]

  def index
    @boss_battles = BossBattle.all

    # ゲームタイトルでフィルタ
    if params[:game_title].present?
      @boss_battles = @boss_battles.by_game(params[:game_title])
    end

    # ボスタイプでフィルタ
    if params[:boss_type].present?
      @boss_battles = @boss_battles.by_type(params[:boss_type])
    end

    # 難易度でフィルタ
    if params[:difficulty].present?
      @boss_battles = @boss_battles.by_difficulty(params[:difficulty])
    end

    @boss_battles = @boss_battles.by_order.includes(:area)

    # フィルタオプション用のデータ
    @game_titles = Challenge::GAME_TITLES
    @boss_types = BossBattle.boss_types.keys.map { |key| [BossBattle.new(boss_type: key).boss_type_display, key] }
    @difficulties = BossBattle::DIFFICULTY_LEVELS.map { |level, info| [info[:name], level] }
  end

  def show
    @strategy_guides = StrategyGuide.published.for_boss(@boss_battle.id).recent.limit(5)
  end

  def by_game
    @game_title = params[:game_title]
    redirect_to boss_battles_path(game_title: @game_title)
  end

  def by_type
    @boss_type = params[:boss_type]
    redirect_to boss_battles_path(boss_type: @boss_type)
  end

  private

  def set_boss_battle
    @boss_battle = BossBattle.find(params[:id])
  end

  def boss_battle_params
    params.require(:boss_battle).permit(:game_title, :boss_type, :difficulty)
  end
end
