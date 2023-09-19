require "test_helper"

class AboutControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get about_new_url
    assert_response :success
  end
end
