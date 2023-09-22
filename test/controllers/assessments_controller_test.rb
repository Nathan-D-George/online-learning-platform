require "test_helper"

class AssessmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get assessments_new_url
    assert_response :success
  end

  test "should get create" do
    get assessments_create_url
    assert_response :success
  end

  test "should get edit" do
    get assessments_edit_url
    assert_response :success
  end

  test "should get update" do
    get assessments_update_url
    assert_response :success
  end

  test "should get destroy" do
    get assessments_destroy_url
    assert_response :success
  end

  test "should get new_quiz" do
    get assessments_new_quiz_url
    assert_response :success
  end

  test "should get create_quiz" do
    get assessments_create_quiz_url
    assert_response :success
  end
end
