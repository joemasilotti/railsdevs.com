require "test_helper"

class SentMessageTest < ActiveSupport::TestCase
  include NotificationsHelper

  test "creating a message sends a notification to the recipient" do
    developer = developers(:prospect)
    business = businesses(:subscriber)
    conversation = conversations(:one)
    user = developer.user

    assert_difference "Notification.count", 1 do
      result = SentMessage.new({body: "Hello!"}, user:, conversation:, sender: developer).create

      notification = last_message_notification
      assert_equal notification.type, NewMessageNotification.name
      assert_equal notification.recipient, business.user
      assert_equal notification.to_notification.message, result.message
      assert_equal notification.to_notification.conversation, conversations(:one)
    end
  end
end
