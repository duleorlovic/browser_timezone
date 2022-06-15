class ApplicationController < ActionController::Base
  around_action :_use_time_zone

  def _use_time_zone(&action)
    result = TimezoneFromCookieForUser.new(current_user).perform cookies['browser.timezone']
    Time.use_zone result.data[:timezone], &action
  end
end
