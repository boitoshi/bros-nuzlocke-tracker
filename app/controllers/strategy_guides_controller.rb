class StrategyGuidesController < ApplicationController
  before_action :set_strategy_guide, only: [:show, :increment_views, :toggle_like]

  def index
    @strategy_guides = StrategyGuide.published

    # 検索
    if params[:search].present?
      @strategy_guides = @strategy_guides.search(params[:search])
    end

    # ゲームタイトルでフィルタ
    if params[:game_title].present?
      @strategy_guides = @strategy_guides.by_game(params[:game_title])
    end

    # ガイドタイプでフィルタ
    if params[:guide_type].present?
      @strategy_guides = @strategy_guides.by_type(params[:guide_type])
    end

    # 難易度でフィルタ
    if params[:difficulty].present?
      @strategy_guides = @strategy_guides.by_difficulty(params[:difficulty])
    end

    # タグでフィルタ
    if params[:tags].present?
      tag_array = params[:tags].split(',').map(&:strip)
      @strategy_guides = @strategy_guides.by_tags(tag_array)
    end

    # ソート
    case params[:sort]
    when 'popular'
      @strategy_guides = @strategy_guides.popular
    when 'recent'
      @strategy_guides = @strategy_guides.recent
    else
      @strategy_guides = @strategy_guides.recent
    end

    @strategy_guides = @strategy_guides.includes(:target_boss).limit(20)

    # フィルタオプション用のデータ
    @game_titles = Challenge::GAME_TITLES
    @guide_types = StrategyGuide.guide_types.keys.map { |key| [StrategyGuide.new(guide_type: key).guide_type_display, key] }
    @difficulties = BossBattle::DIFFICULTY_LEVELS.map { |level, info| [info[:name], level] }
  end

  def show
    @strategy_guide.increment_views!
    @related_guides = StrategyGuide.published
                                  .where.not(id: @strategy_guide.id)
                                  .by_game(@strategy_guide.game_title)
                                  .limit(5)
  end

  def by_game
    @game_title = params[:game_title]
    redirect_to strategy_guides_path(game_title: @game_title)
  end

  def by_type
    @guide_type = params[:guide_type]
    redirect_to strategy_guides_path(guide_type: @guide_type)
  end

  def search
    @query = params[:q]
    @strategy_guides = StrategyGuide.published.search(@query).recent.includes(:target_boss)
    render :index
  end

  def increment_views
    @strategy_guide.increment_views!
    head :ok
  end

  def toggle_like
    if session[:liked_guides] ||= []
      if session[:liked_guides].include?(@strategy_guide.id)
        session[:liked_guides].delete(@strategy_guide.id)
        @strategy_guide.decrement_likes!
        @liked = false
      else
        session[:liked_guides] << @strategy_guide.id
        @strategy_guide.increment_likes!
        @liked = true
      end
    end

    respond_to do |format|
      format.json { render json: { liked: @liked, likes_count: @strategy_guide.likes_count } }
    end
  end

  private

  def set_strategy_guide
    @strategy_guide = StrategyGuide.find(params[:id])
  end

  def strategy_guide_params
    params.require(:strategy_guide).permit(:game_title, :guide_type, :difficulty, :search, :tags)
  end
end
