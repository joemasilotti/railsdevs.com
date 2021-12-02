require "test_helper"

class MessagesTest < ActionDispatch::IntegrationTest
  setup do
    @developer = developers(:available)
    @business = businesses(:one)
  end

  test "must be signed in" do
    get new_developer_message_path(@developer)
    assert_redirected_to new_user_registration_path

    post developer_messages_path(@developer)
    assert_redirected_to new_user_registration_path
  end

  test "must have a business profile" do
    sign_in users(:empty)

    get new_developer_message_path(@developer)
    assert_redirected_to new_business_path

    post developer_messages_path(@developer)
    assert_redirected_to new_business_path
  end

  test "starting a new conversation" do
    sign_in @business.user
    get new_developer_message_path(@developer)
    assert_select "form[action=?]", developer_messages_path(@developer)
  end

  test "creating a new conversation" do
    sign_in @business.user

    assert_difference "Message.count", 1 do
      assert_difference "Conversation.count", 1 do
        post developer_messages_path(@developer), params: message_params
      end
    end

    assert_redirected_to developer_conversation_path(@developer)
    follow_redirect!
    assert_select "h1", text: /^Conversation/
  end

  test "trying to start an existing conversation" do
    sign_in @business.user
    Conversation.create!(developer: @developer, business: @business)

    get new_developer_message_path(@developer)

    assert_redirected_to developer_conversation_path(@developer)
  end

  test "trying to continue an existing conversation" do
    sign_in @business.user
    Conversation.create!(developer: @developer, business: @business)

    assert_no_difference "Message.count" do
      assert_no_difference "Conversation.count" do
        post developer_messages_path(@developer), params: message_params
      end
    end

    assert_redirected_to developer_conversation_path(@developer)
  end

  def message_params
    {
      message: {
        body: "Hello!"
      }
    }
  end
end
