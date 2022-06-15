// https://github.com/duleorlovic/browser_timezone/blob/main/app/javascript/browser_timezone_cookie.js
import Cookies from 'js-cookie'

Cookies.set(
  "browser.timezone",
  Intl.DateTimeFormat().resolvedOptions().timeZone,
  {
    expires: 365,
    path: '/'
  }
);
