require "test_helper"

class ReadNotificationsTest < ActionDispatch::IntegrationTest
  include NotificationsHelper

  test "you must be signed in" do
    get read_notifications_path
    assert_redirected_to new_user_registration_path
  end

  test "you can view the history page even if no read notifications exist" do
    sign_in users(:business)

    get read_notifications_path
    assert_select "h3", "No read notifications"
  end

  test "you can view your past notifications if you have past (read) notifications" do
    user = users(:business)
    sign_in user
    create_message_and_notification!(developer: developers(:one), business: user.business)
    last_message_notification.mark_as_read!

    get read_notifications_path

    assert_select "h1", "Read notifications"
  end

  test "you can read all unread notifications" do
    user = users(:business)
    sign_in user
    Notification.create!(recipient: user, type: ApplicationNotification)
    Notification.create!(recipient: user, type: ApplicationNotification)
    assert_equal 2, user.notifications.unread.count

    post read_notifications_path

    assert_redirected_to notifications_path
    assert_equal 0, user.notifications.unread.count
    assert_equal 2, user.notifications.read.count
  end
end
