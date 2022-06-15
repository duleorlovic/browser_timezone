# Browser Timezone

Use timezone from browser on the client side and save to users table so we can
use it when we do not have client side info (for example we want to send
notification in user's timezone).

Start with devise gem template
https://github.com/duleorlovic/devise_gem_tips
```
rails new browser_timezone -m https://raw.githubusercontent.com/duleorlovic/devise_gem_tips/main/template.rb
```

and add user timezone_manual and timezone_browser columns
```
rails g migration add_timezone_browser_to_users timezone_browser timezone_manual
```

Pin js-cookie library
```
bin/importmap pin js-cookie
```
so we can use it
```
// app/javascript/browser_timezone_cookie.js
import Cookies from 'js-cookie'

Cookies.set(
  "browser.timezone",
  Intl.DateTimeFormat().resolvedOptions().timeZone,
  {
    expires: 365,
    path: '/'
  }
);
```

and include it in main application.js
```
// app/javascript/application.js
import "./browser_timezone_cookie"
```

Note that cookie is not sent on first GET request, only the second and all
others (for same domain it stays forever).

We use in around_action in application_controller
```
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  around_action :_use_time_zone

  def _use_time_zone(&action)
    result = TimezoneFromCookieForUser.new(current_user).perform cookies['browser.timezone']
    Time.use_zone result.data[:timezone], &action
  end
end
```

Change timezone using plugin https://chrome.google.com/webstore/detail/change-timezone-for-googl/cejckpjfigehbeecbbfhangbknpidcnh
