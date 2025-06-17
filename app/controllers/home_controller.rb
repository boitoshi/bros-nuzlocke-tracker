class HomeController < ApplicationController
  def index
    if user_signed_in?
      @active_challenges = current_user.active_challenges.limit(3)
      @total_challenges = current_user.challenges.count
      @completed_challenges = current_user.completed_challenges.count
    end
  end
end
