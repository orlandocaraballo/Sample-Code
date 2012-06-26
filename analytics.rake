namespace :analytics do
  require 'analytics/analytics_service'
  
  desc 'get analytics info by user id'
  task :get_by_uid, :uid, :time_travel, :needs => :environment do |t, args|
    user = User.find(args[:uid])
    puts AnalyticsService::gather(user, { :time_travel => args[:time_travel] })
  end
  
  desc 'cache all analytics information'
  task :cache_all => :environment do
      start_time = Time.now
      
      count = 0
      # only for Paying users only
      User.trial.each do |u|
        # run this task for both month and week data
        ['week', 'month'].each do |time_travel|
          # check to see if user has a theme associated with it
          if !u.theme.nil?
            begin
              # analytics throttling only every 10 calls
              sleep(2) if count % 10 == 0
              # get the google information for this theme and this time period (time_travel)
              googs_output = AnalyticsService::gather(u, { :time_travel => time_travel })
              count += 1
            rescue Exception => e
              PostOffice.send_simple_message('Analytics Cache Error', e.message + "\n" + e.backtrace.join("\n"))
              next
            end
            
            current_analytics = Analytics.find_by_theme_id_and_time_travel(u.theme.id, time_travel)
                              
            # if entry exists then update otherwise add to db
            if current_analytics.nil?
              current_analytics = Analytics.new(googs_output.merge({ :theme_id => u.theme.id, :time_travel => time_travel }))
            else
              current_analytics.attributes = googs_output
            end
            
            if current_analytics.save
              puts "Cached analytics for theme -> #{u.theme.id} : #{u.email}, threshold = #{time_travel}"
            else
              puts "Could not cache analytics for theme -> #{u.theme.id} : #{u.email}"
            end
          end
        end
      end
      
      puts "Total runtime -> #{Time.now - start_time} seconds"
  end
end