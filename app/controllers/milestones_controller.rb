class MilestonesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_challenge
  before_action :set_milestone

  def toggle_complete
    if @milestone.completed?
      @milestone.update!(completed_at: nil, completion_data: nil)
      redirect_back_or_to progress_challenge_path(@challenge),
                          notice: "#{@milestone.name}を未完了に戻しました。"
    else
      @milestone.complete!(party_level: @challenge.party_pokemon.average(:level)&.round)
      EventLog.log_milestone_completed(@challenge, @milestone)
      redirect_back_or_to progress_challenge_path(@challenge),
                          notice: "#{@milestone.milestone_type_icon} #{@milestone.name}を達成！🎉"
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
