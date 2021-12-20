require "test_helper"

class ColdMessagesTest < ActionDispatch::IntegrationTest
  include PayHelper

  setup do
    @developer = developers(:available)
    @business = businesses(:with_conversation)
  end

  test "must be signed in" do
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

  test "must have an active business subscription" do
    sign_in businesses(:one).user
    stub_pay(businesses(:one).user, expected_success_url: new_developer_message_url(@developer)) do
      get new_developer_message_path(@developer)
      assert_redirected_to "checkout.stripe.com"
    end
  end

  test "a business can start a new conversation" do
    sign_in @business.user
    get new_developer_message_path(@developer)
    assert_select "form[action=?]", developer_messages_path(@developer)
  end

  test "a business can create a new conversation" do
    sign_in @business.user

    assert_difference "Message.count", 1 do
      assert_difference "Conversation.count", 1 do
        post developer_messages_path(@developer), params: message_params
      end
    end

    assert_redirected_to conversation_path(Conversation.last)
    follow_redirect!
    assert_select "h1", text: /^Conversation/
  end

  test "starting an existing conversation redirects to the conversation" do
    sign_in @business.user
    conversation = Conversation.create!(developer: @developer, business: @business)

    get new_developer_message_path(@developer)

    assert_redirected_to conversation_path(conversation)
  end

  test "an invalid message re-renders the form" do
    sign_in @business.user

    assert_no_difference "Message.count" do
      assert_no_difference "Conversation.count" do
        post developer_messages_path(@developer), params: {message: {body: nil}}
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
