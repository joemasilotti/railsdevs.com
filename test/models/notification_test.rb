require "test_helper"

class NotificationTest < ActiveSupport::TestCase
  include NotificationsHelper

  test "conversation resolves correctly" do
    developer = developers(:available)
    business = businesses(:one)
    message = Message.create!(developer:, business:, sender: developer, body: "Hello!")

    assert last_message_notification.to_notification.conversation == message.conversation
  end

  test "message resolves correctly" do
    developer = developers(:available)
    business = businesses(:one)
    message = Message.create!(developer:, business:, sender: developer, body: "Hello!")

    assert last_message_notification.to_notification.message == message
  end
end
