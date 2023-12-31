require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get messages_new_url
    assert_response :success
  end

  test "should get create" do
    get messages_create_url
    assert_response :success
  end

  test "should get destroy" do
    get messages_destroy_url
    assert_response :success
  end

  test "should get message" do
    get messages_message_url
    assert_response :success
  end
end
