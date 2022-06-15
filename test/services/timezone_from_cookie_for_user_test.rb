require "test_helper"

class TimezoneFromCookieForUserTest < ActiveSupport::TestCase
  test "use timezone_manual" do
    user = users(:user)
    user.timezone_manual = "Europe/London"
    result = TimezoneFromCookieForUser.new(user).perform
    expected = Time.find_zone "Europe/London"
    assert_equal expected, result.data[:timezone]
  end

  test "use default timezone when no manual" do
    user = users(:user)
    result = TimezoneFromCookieForUser.new(user).perform
    expected = Time.find_zone "UTC"
    assert_equal expected, result.data[:timezone]
  end

  test "update users.timezone_manual from browser_timezone" do
    user = users(:user)
    result = TimezoneFromCookieForUser.new(user).perform "Europe/London"
    assert result.success?
    assert_equal "Europe/London", user.timezone_browser
  end

  test "use browser_timezone with +" do
    browser_timezone = "Etc/GMT 8"
    result = TimezoneFromCookieForUser.new.perform browser_timezone
    expected = Time.find_zone "Etc/GMT+8"
    assert_equal expected, result.data[:timezone]
  end
end
