# Sample Code
In this project I have consolodated some sample code for various projects I have worked on in the past. I only uploaded the code I worked on so there are obviously some missing sections.

## 2012- ReclipIt - ImageCleaner
This project began as a simple fix but became more complex once I realized the nature of the problem. The code in clips.js.coffee is an exerpt that isolates the portion of code that grabs the images from a "clipped" (refer to bookmarklet) website and allows you to choose a image to associated with that "clip" in the ReclipIt system. The problem here was parsing out images of a certain height/width all in javascript/coffeescript. The code dynamically loads an array of images, using their respective url's, and cleverly calculates their width and height then renders the parsed images onto the page. It accounts for possible 404/403 errors, forces the images to render within 3 minutes and does this asynchronously (there is a loading gif that display in the meantime). You can see it in action if you click on the clipit button (heart+ button upper right) [here](http://reclipit.com/). When it asks you for a web url enter the url of an image heavy site like [the verge](http://theverge.com) or [cnn](http://cnn.com).


## 2012- ReclipIt - Bookmarklet
Listed here is a portion of the code from the Bookmarklet (clipmarklet) project I worked on while at Citypockets. You can test out the bookmarklet (clip it button) [here](http://reclipit.com/about/clip-it-button).

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
Listed here is a portion of the code from the an analytics project I worked on while at Onepager. You see the analytics frontend in action if you are a premium user on [Onepager](http://onepagerapp.com).

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