require "test_helper"

class SentMessageTest < ActiveSupport::TestCase
  include NotificationsHelper
  include PunditHelper

  setup do
    @developer = developers(:prospect)
    @business = businesses(:subscriber)
    @conversation = conversations(:one)
    @user = @developer.user
  end

  test "creating a message is successful" do
    assert_difference "Message.count", 1 do
      result = create_sent_message!
      assert result.success?
      assert_equal Message.last, result.message
    end
  end

  test "invalid messages are not created" do
    assert_no_difference "Message.count" do
      result = create_sent_message!(body: nil)
      refute result.success?
      assert result.message.invalid?
    end
  end

  test "creating a message sends a notification to the recipient" do
    assert_difference "Notification.count", 1 do
      result = create_sent_message!

      notification = last_message_notification
      assert_equal notification.type, NewMessageNotification.name
      assert_equal notification.recipient, @business.user
      assert_equal notification.to_notification.message, result.message
      assert_equal notification.to_notification.conversation, conversations(:one)
    end
  end

  test "the messaging policy is authorized for the create action" do
    stub_not_authorized_pundit_policy(@user, Message, :create?, MessagingPolicy) do
      create_sent_message!
    end
  end

  test "the subscription policy is authorized for the messageable action" do
    stub_not_authorized_pundit_policy(@user, Message, :messageable?, SubscriptionPolicy) do
      create_sent_message!
    end
  end

  def create_sent_message!(options = {body: "Hello!"})
    SentMessage.new(options, user: @user, conversation: @conversation, sender: @developer).create
  end
end
