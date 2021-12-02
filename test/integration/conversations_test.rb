require "test_helper"

class ConversationsTest < ActionDispatch::IntegrationTest
  setup do
    @developer = developers(:available)
    @business = businesses(:one)
    sign_in @business.user
  end

  test "starting a new conversation" do
    get new_developer_conversation_path(@developer)
    assert_response :ok
  end

  test "trying to start an existing conversation" do
    conversation = Conversation.create!(developer: @developer, business: @business)
    get new_developer_conversation_path(@developer)
    assert_redirected_to conversation_path(conversation)
  end

  test "sending a message in a new conversation" do
    assert_difference "Conversation.count", 1 do
      assert_difference "Message.count", 1 do
        post_conversation("Hello!")
      end
    end

    assert_redirected_to conversation_path(Conversation.last)
    follow_redirect!
    assert_equal Conversation.last.messages.last.body, "Hello!"
  end

  test "sending a message to an existing conversation" do
    conversation = Conversation.create!(developer: @developer, business: @business)

    assert_no_difference "Conversation.count" do
      assert_no_difference "Message.count", 1 do
        post_conversation("Hello, again!")
      end
    end

    assert_redirected_to conversation_path(conversation)
  end

  def post_conversation(message)
    post conversations_path(@developer), params: {
      conversation: {
        developer_id: @developer.id,
        business_id: @business.id,
        messages_attributes: [
          {
            body: message
          }
        ]
      }
    }
  end
end
