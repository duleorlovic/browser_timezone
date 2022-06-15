class ApplicationController < ActionController::Base
  around_action :_use_time_zone

  # https://github.com/duleorlovic/browser_timezone/blob/main/app/controllers/application_controller.rb
  def _use_time_zone(&action)
    result = TimezoneFromCookieForUser.new(current_user).perform cookies['browser.timezone']
    Time.use_zone result.data[:timezone], &action
  end
end
