class Dashboard::AnalyticsController < ApplicationController
  layout 'dashboard'
  before_filter :require_user
  before_filter :trial_dashboard

  def index
    @time_travel = params[:time_travel] == 'month' ? 'month' : 'week'
    @analytics = Analytics.data(current_user.theme.id, @time_travel)
  end
end