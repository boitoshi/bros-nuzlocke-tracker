class HomeController < ApplicationController
  def index
    if user_signed_in?
      begin
        @active_challenges = current_user.active_challenges.limit(3)
        @total_challenges = current_user.challenges.count
        @completed_challenges = current_user.completed_challenges.count
      rescue StandardError => e
        Rails.logger.error "Home controller error: #{e.message}"
        # エラー時はデフォルト値を設定
        @active_challenges = []
        @total_challenges = 0
        @completed_challenges = 0
      end
    end
  end
end
