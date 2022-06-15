# https://github.com/duleorlovic/browser_timezone/blob/main/app/services/timezone_from_cookie_for_user.rb
class TimezoneFromCookieForUser
  def initialize(user = nil)
    @user = user
  end

  def perform(browser_timezone = nil)
    timezone = \
      if @user.present? && @user.timezone_manual.present?
        Time.find_zone @user.timezone_manual
      else
        timezone_browser = find_browser_timezone browser_timezone
        @user.update! timezone_browser: timezone_browser.tzinfo.name if @user.present? && timezone_browser.present?
        timezone_browser
      end
    Result.new "OK", timezone: timezone || Time.zone
  end

  def find_browser_timezone(browser_timezone)
    #  When browser sends "Etc/GMT 8" we will store "Etc/GMT+8"
    Time.find_zone browser_timezone.to_s.gsub(" ", "+")
  end
end
