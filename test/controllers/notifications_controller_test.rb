require "test_helper"

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get notifications_list_url
    assert_response :success
  end
end
