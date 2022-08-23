require "test_helper"

class NotificationTest < ActiveSupport::TestCase
  setup do
    developer = developers(:one)
    business = businesses(:one)

    @message = Message.new(developer:, business:, sender: developer, body: "Hello!")
    assert @message.save_and_notify

    @notification = Notification.where(type: NewMessageNotification.name).last
  end

  test "message resolves correctly" do
    assert_equal @message, @notification.to_notification.message
  end

  test "conversation resolves correctly" do
    assert_equal @message.conversation, @notification.to_notification.conversation
  end
end
