# Sample Code
In this project I have consolodated some sample code for various projects I have worked on in the past. I only uploaded the code I worked on so there are obviously some missing sections.

## 2012- ReclipIt - Bookmarklet
Listed here is a portion of the code from the Bookmarklet (clipmarklet) project I worked on while at Citypockets.

The following files are included:

### Javascript/Coffescript
- clipmarklet-browser.js - the code that runs in the browser and remotely calls the clipmarklet-initialize coffeescript
- clipmarklet-initialize.js.coffee.erb - the code that generates the bookmarklet html and styles it
- clipmarklet.js.coffee - the script that establishes some utility methods to call on clipmarklet related pages

### Controllers
- clipmarklets_controller.rb

### Views
- clipmarklet.html.haml - bookmarklet layout
- duplicate.html.haml - for when clips already exist in the system
- error.html.haml - for when there is an error retreiving an existing clip
- new.html.haml - the add a new clip view but within a popup window

##2011 - Onepager - Analytics
Listed here is a portion of the code from the an analytics project I worked on while at Onepager.

The following files are included:

- Model - analytics.rb
- View - index.html.erb
- Controller - analytics_controler.rb
- [Cron] Rake task** - analytics.rake
- Migration - 20110922184849_create_analytics_rb
- Service Wrapper for Analytics*** - analytics_service.rb
- Garb Model**** - visitors_grouped.rb

** - This is the task that gets run on cron to gather all page analytics info.

*** - This is the library I created for gathering page analytics information. Should be pretty straightforward.

**** - I used the garb gem to interface with the google analytics api. Using garb I had to declare what dimensions and metrics
would need to be extracted from google. This file is a reflection of that.