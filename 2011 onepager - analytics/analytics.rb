class Analytics < ActiveRecord::Base
  require 'analytics/analytics_service'
  
  has_one :theme
  serialize :deep_dive, Array
  serialize :keywords, Array
  serialize :sources, Array

  def self.default(time_travel)
    time_travel = time_travel == :month ? :month : :week
    a_week_ago = 1.week.ago
    a_month_ago = 1.month.ago
    
    # setup initial deep dive month and week defaults (dummy data according to day of week)
    if time_travel == :month
      deep_dive = Array.new(30) do |i|
        current_date = a_month_ago + i.day
        { :month => current_date.strftime('%m'), :day => current_date.strftime('%d'), :visits => 0 }
      end
    else
      deep_dive = Array.new(7) do |i|
        current_date = a_week_ago + i.day
        { :month => current_date.strftime('%m'), :day => current_date.strftime('%d'), :visits => 0 }
      end
    end
     
    Analytics.new(
      :total_views => 0,
      :avg_time_on_site => 0,
      :new_visitors => 0,
      :deep_dive => deep_dive,
      :keywords => [],
      :sources => [],
      :time_travel => time_travel,
    )
  end

  def self.data(theme_id, time_travel)
    Analytics.where(:theme_id => theme_id, :time_travel => time_travel).first
  end
end