class MilestonesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_challenge
  before_action :set_milestone

  def toggle_complete
    if @milestone.completed?
      @milestone.update!(completed_at: nil, completion_data: nil)
    else
      @milestone.complete!(party_level: @challenge.party_pokemon.average(:level)&.round)
      EventLog.log_milestone_completed(@challenge, @milestone)
    end

    respond_to do |format|
      format.json do
        # 同カテゴリのカウントを返す
        category_milestones = @challenge.milestones.where(milestone_type: @milestone.milestone_type)
        render json: {
          completed: @milestone.completed?,
          completed_date: @milestone.completed? ? @milestone.completed_at.strftime('%m/%d') : nil,
          category: @milestone.milestone_type,
          category_completed: category_milestones.completed.count,
          category_total: category_milestones.count
        }
      end
      format.html do
        if @milestone.completed?
          redirect_back_or_to progress_challenge_path(@challenge),
                              notice: "#{@milestone.milestone_type_icon} #{@milestone.name}を達成！🎉"
        else
          redirect_back_or_to progress_challenge_path(@challenge),
                              notice: "#{@milestone.name}を未完了に戻しました。"
        end
      end
    end
  end

  private

  def set_challenge
    @challenge = current_user.challenges.find(params[:challenge_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to challenges_path, alert: "指定されたチャレンジが見つかりません。"
  end

  def set_milestone
    @milestone = @challenge.milestones.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to progress_challenge_path(@challenge), alert: "指定されたマイルストーンが見つかりません。"
  end

  def redirect_back_or_to(fallback_path, **options)
    redirect_to((request.referer.presence || fallback_path), **options)
  end
end
