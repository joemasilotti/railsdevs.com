require "test_helper"

class MessagesTest < ActionDispatch::IntegrationTest
  setup do
    @developer = developers(:with_conversation)
    @business = businesses(:with_conversation)
    @conversation = conversations(:one)
  end

  test "must be signed in" do
    post conversation_messages_path(@conversation)
    assert_redirected_to new_user_registration_path
  end

  test "can't view blocked conversations" do
    sign_in @developer.user
    @conversation.touch(:developer_blocked_at)

    assert_raises ActiveRecord::RecordNotFound do
      post conversation_messages_path(@conversation), params: message_params
    end
  end

  test "the developer in the conversation can continue the conversation" do
    sign_in @developer.user

    assert_difference "Message.count", 1 do
      assert_no_difference "Conversation.count" do
        post conversation_messages_path(@conversation), params: message_params
      end
    end
    assert_equal Message.last.sender, @developer

    assert_redirected_to conversation_path(@conversation)
    follow_redirect!
    assert_select "p", text: "Hello!"
  end

  test "the business in the conversation can continue the conversation" do
    sign_in @business.user

    assert_difference "Message.count", 1 do
      assert_no_difference "Conversation.count" do
        post conversation_messages_path(@conversation), params: message_params
      end
    end
    assert_equal Message.last.sender, @business

    assert_redirected_to conversation_path(@conversation)
    follow_redirect!
    assert_select "p", text: "Hello!"
  end

  test "no one else can contribute to the conversation" do
    sign_in users(:empty)

    assert_no_difference "Message.count" do
      post conversation_messages_path(@conversation), params: message_params
    end

    assert_redirected_to root_path
  end

  test "an invalid message re-renders the form" do
    sign_in @business.user

    assert_no_difference "Message.count" do
      assert_no_difference "Conversation.count" do
        post conversation_messages_path(@conversation), params: {message: {body: nil}}
      end
    end

    assert_response :unprocessable_entity
  end

  def message_params
    {
      message: {
        body: "Hello!"
      }
    }
  end
end
