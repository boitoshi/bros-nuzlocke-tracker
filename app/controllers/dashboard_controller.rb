class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @challenge_stats = current_user.challenges.total_stats
    @pokemon_stats = Pokemon.joins(:challenge).where(challenges: { user: current_user }).total_stats
    
    # グラフ用データ
    @game_title_data = current_user.challenges.game_title_stats
    @species_popularity_data = Pokemon.joins(:challenge)
                                      .where(challenges: { user: current_user })
                                      .species_popularity_stats(10)
    @level_distribution_data = Pokemon.joins(:challenge)
                                      .where(challenges: { user: current_user })
                                      .level_distribution_stats
    @monthly_challenges_data = current_user.challenges.monthly_creation_stats(12)
    @monthly_catches_data = Pokemon.joins(:challenge)
                                   .where(challenges: { user: current_user })
                                   .monthly_catch_stats(12)
    
    # 追加統計
    @nature_stats = Pokemon.joins(:challenge)
                           .where(challenges: { user: current_user })
                           .nature_stats
    @area_catch_stats = Pokemon.joins(:challenge)
                               .where(challenges: { user: current_user })
                               .area_catch_stats
    @party_usage_stats = Pokemon.joins(:challenge)
                                .where(challenges: { user: current_user })
                                .party_usage_stats
    
    # 平均値統計
    @average_duration = current_user.challenges.average_duration
  end
end
