Sample-Code
===========
Listed here is a portion of the code from the analytics project.

The following types of files are included:

- Model -> analytics.rb
- View -> index.html.erb
- Controller -> analytics_controler.rb
- [Cron] Rake task* -> analytics.rake
- Migration -> 20110922184849_create_analytics_rb
- Service Wrapper for Analytics** -> analytics_service.rb
- Garb Model*** -> visitors_grouped.rb

* - This is the task that gets run on cron to gather all page analytics info.

** - This is the library I created for gathering page analytics information. Should be pretty straightforward.

*** - I used the garb gem to interface with the google analytics api. Using garb I had to declare what dimensions and metrics
would need to be extracted from google. This file is a reflection of that.