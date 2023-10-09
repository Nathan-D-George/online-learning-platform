require "test_helper"

class RoomControllerTest < ActionDispatch::IntegrationTest
  test "should get view" do
    get room_view_url
    assert_response :success
  end
end
