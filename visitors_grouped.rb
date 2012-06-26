class VisitorsGrouped
  extend Garb::Model
  
  metrics :pageviews
  dimensions :month, :day, :day_of_week
end