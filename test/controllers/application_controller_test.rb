require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "#_use_time_zone update user.timezone_browser" do
    user = users(:user)
    cookies['browser.timezone'] = 'UTC'
    sign_in user
    get root_path
    assert_equal 'Etc/UTC', user.timezone_browser
  end
end
