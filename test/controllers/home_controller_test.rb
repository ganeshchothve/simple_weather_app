require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get fetch_weather" do
    get home_fetch_weather_url
    assert_response :success
  end
end
