require "test_helper"

class ConversationsTest < ActionDispatch::IntegrationTest
  test "you must be signed in" do
    get conversations_path
    assert_redirected_to new_user_registration_path

    get conversation_path(conversations(:one))
    assert_redirected_to new_user_registration_path
  end

  test "you can view your conversations (as a business)" do
    sign_in users(:with_business_conversation)
    get conversations_path
    assert_select "h2", developers(:with_conversation).hero
  end

  test "you can view your conversations (as a developer)" do
    sign_in users(:with_developer_conversation)
    get conversations_path
    assert_select "h2", businesses(:with_conversation).hero
  end

  test "you can view your own conversation (as a business)" do
    conversation = conversations(:one)
    sign_in conversation.business.user

    get conversation_path(conversation)

    assert_response :ok
  end

  test "you can view your own conversation (as a developer)" do
    conversation = conversations(:one)
    sign_in conversation.developer.user

    get conversation_path(conversation)

    assert_response :ok
  end

  test "you can't view another's conversation" do
    conversation = conversations(:one)
    sign_in users(:empty)

    get conversation_path(conversation)

    assert_redirected_to root_path
  end
end
