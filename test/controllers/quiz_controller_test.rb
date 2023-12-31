require "test_helper"

class QuizControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get quiz_new_url
    assert_response :success
  end

  test "should get create" do
    get quiz_create_url
    assert_response :success
  end

  test "should get edit" do
    get quiz_edit_url
    assert_response :success
  end

  test "should get update" do
    get quiz_update_url
    assert_response :success
  end
end
