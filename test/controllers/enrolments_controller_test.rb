require "test_helper"

class EnrolmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get enrolments_new_url
    assert_response :success
  end

  test "should get create" do
    get enrolments_create_url
    assert_response :success
  end

  test "should get destroy" do
    get enrolments_destroy_url
    assert_response :success
  end
end
