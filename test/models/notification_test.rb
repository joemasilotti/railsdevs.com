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

  test "celebreation promotion notifications are hidden from the UI" do
    notification = create_celebration_promotion_notification
    assert_includes Notification.all, notification
    refute_includes Notification.visible, notification
  end

  def create_celebration_promotion_notification
    Notification.create!(
      type: Developers::CelebrationPromotionNotification,
      recipient: users(:developer)
    )
  end
end
