require "test_helper"

class ConversationsTest < ActionDispatch::IntegrationTest
  test "you must be signed in" do
    get developer_conversation_path(conversations(:one))
    assert_redirected_to new_user_registration_path
  end

  test "viewing your business' conversation" do
    conversation = conversations(:one)
    sign_in conversation.business.user

    get developer_conversation_path(conversation.developer)

    assert_response :ok
  end

  test "viewing another business' conversation" do
    conversation = conversations(:one)
    sign_in conversation.business.user

    get developer_conversation_path(conversation.developer)

    assert_response :ok
  end
end
