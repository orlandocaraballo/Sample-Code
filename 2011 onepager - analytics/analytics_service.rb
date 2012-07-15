class AnalyticsService
  require 'analytics/visitors'
  require 'analytics/visitors_grouped'
  require 'analytics/keywords'
  require 'analytics/sources'
  
  @@profile = nil
  
  # gather all analytics info
  def self.gather(user, opts)
    # only login the first time
    if @@profile.nil?
      Garb::Session.login(APP_CONFIG['google_analytics_un'], APP_CONFIG['google_analytics_pw'])
      @@profile = Garb::Management::Profile.all.first
    end
        
    # decide whether to look for matching domain_name or internal onepager address
    if user.domain_name.blank?
      @address = { :page_path.eql => '/' + user.onepager_address }
    else
      @address = { :hostname.eql => user.domain_name }
    end
    
    @sort = :visits.desc
    @limit = 10
    @end_date = Date.yesterday
    a_week_ago = 1.week.ago
    a_month_ago = 1.month.ago
    
    # gather information for 1 week or by month
    if opts[:time_travel] == 'week'
      visitors = visitors(a_week_ago)
      visitors_grouped = visitors_grouped(a_week_ago)
      keywords = keywords(a_week_ago)
      sources = sources(a_week_ago)
    else
      visitors = visitors(a_month_ago)
      visitors_grouped = visitors_grouped(a_month_ago)
      keywords = keywords(a_month_ago)
      sources = sources(a_month_ago)
    end
    
    # setup initial return hash
    var_hash = {
      :keywords => keywords,
      :sources => sources,
      :deep_dive => visitors_grouped,
      # set all vars to zero initially
      :total_views => 0,
      :avg_time_on_site => 0,
      :new_visitors => 0,
    }
    
    # if data is returned from the googs then replace initial data with real data
    if !visitors.nil?
      var_hash[:total_views] = visitors.pageviews
      var_hash[:avg_time_on_site] = visitors.avg_time_on_page
      var_hash[:new_visitors] = visitors.percent_new_visits
    end
    
    return var_hash
  end
  
private  
  def self.visitors(start_date)
    @@profile.visitors(:filters => @address, :start_date => start_date).to_a[0]
  end
  
  def self.visitors_grouped(start_date)
    visitors_grouped = []
    @@profile.visitors_grouped(
      :filters => @address, 
      :start_date => start_date,
      :end_date => @end_date
    ).to_a.each {|i| visitors_grouped << { :day => i.day, :month => i.month, :day_of_week => i.day_of_week, :visits => i.pageviews } }
    
    return visitors_grouped
  end
  
  def self.keywords(start_date)
    keywords = []
    @@profile.keywords(
      :filters => @address.merge({ :keyword.does_not_match => '(not set)' }),
      :limit => @limit, 
      :sort => @sort,
      :start_date => start_date,
      :end_date => @end_date
    ).to_a.each {|i| keywords << { :keyword => i.keyword, :visits => i.visits } }
    
    return keywords
  end
  
  def self.sources(start_date)
    sources = []
    @@profile.sources(
      :filters => @address.merge({ :source.does_not_match => '(direct)' }),
      :limit => @limit,
      :sort => @sort,
      :start_date => start_date,
      :end_date => @end_date
    ).to_a.each {|i| sources << { :source => i.source, :visits => i.visits } }
    
    return sources
  end
end