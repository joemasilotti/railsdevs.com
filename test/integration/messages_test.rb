require "test_helper"

class MessagesTest < ActionDispatch::IntegrationTest
  include NotificationsHelper
  include PayHelper
  include SubscriptionsHelper

  setup do
    @developer = developers(:prospect)
    @business = businesses(:subscriber)
    @conversation = conversations(:one)
  end

  test "must be signed in" do
    post conversation_messages_path(@conversation)
    assert_redirected_to new_user_session_path
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
        assert_sends_notification NewMessageNotification do
          post conversation_messages_path(@conversation), params: message_params
        end
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

  test "a business without an active subscription can no longer continue the conversation" do
    pay_subscriptions(:full_time).update!(ends_at: Date.yesterday)
    sign_in @business.user

    assert_no_difference "Message.count" do
      post conversation_messages_path(@conversation), params: message_params
    end
    assert_redirected_to pricing_path
  end

  test "no one else can contribute to the conversation" do
    sign_in users(:empty)

    assert_no_difference "Message.count" do
      post conversation_messages_path(@conversation), params: message_params
    end

    assert_redirected_to root_path
  end

  test "part-time plan subscribers can't message full-time seekers" do
    sign_in @business.user
    update_subscription(:part_time)
    @developer.role_type.update!(
      part_time_contract: false,
      full_time_contract: false,
      full_time_employment: true
    )

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

  test "messages are formatted" do
    sign_in @business.user
    @conversation.messages.last.update!(body: "Line 1\n\nLine 2")

    get conversation_path(@conversation)

    assert_select "p", text: "Line 1"
    assert_select "p", text: "Line 2"
  end

  test "links are clickable" do
    sign_in @business.user
    @conversation.messages.last.update!(body: "Check out https://railsdevs.com/!")

    get conversation_path(@conversation)

    assert_select "p", html: 'Check out <a href="https://railsdevs.com/" target="_blank">https://railsdevs.com/</a>!'
  end

  test "email developer tips when they receive their first message" do
    sign_in @business.user
    developer = users(:developer).developer

    assert_enqueued_email_with DeveloperMailer, :first_message, args: {developer:} do
      post developer_messages_path(developer), params: message_params
    end
  end

  def message_params
    {
      message: {
        body: "Hello!"
      }
    }
  end
end
