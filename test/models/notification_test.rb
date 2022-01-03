require "test_helper"

class NotificationTest < ActiveSupport::TestCase
  test "conversation resolves correctly" do
    developer = developers(:available)
    business = businesses(:one)
    message = Message.create!(developer: developer, business: business, sender: developer, body: "Hello!")

    assert Notification.last.to_notification.conversation == message.conversation
  end

  test "message resolves correctly" do
    developer = developers(:available)
    business = businesses(:one)
    message = Message.create!(developer: developer, business: business, sender: developer, body: "Hello!")

    assert Notification.last.to_notification.message == message
  end
end
