module NotificationsHelper
  def assert_sends_notification(notification_class, to: nil, &block)
    assert_difference "Notification.where(type: #{notification_class}.name).count", 1 do
      yield
    end

    if to.present?
      assert_equal Notification.where(type: notification_class.name).last.recipient, to
    end
  end

  def refute_sends_notification(notification_class, &block)
    assert_no_difference "Notification.where(type: #{notification_class}.name).count" do
      yield
    end
  end

  def refute_sends_notifications
    assert_no_difference "Notification.count" do
      yield
    end
  end
end
