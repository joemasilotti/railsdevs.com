module NotificationsHelper
  def assert_sends_notification(notification_class, to: nil)
    assert_difference "Notification.where(type: #{notification_class}.name).count", 1, &block

    assert_equal Notification.where(type: notification_class.name).last.recipient, to if to.present?
  end

  def refute_sends_notification(notification_class)
    assert_no_difference "Notification.where(type: #{notification_class}.name).count", &block
  end

  def refute_sends_notifications(&block)
    assert_no_difference 'Notification.count', &block
  end
end
