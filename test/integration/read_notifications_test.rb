require "test_helper"

class ReadNotificationsTest < ActionDispatch::IntegrationTest
  test "you must be signed in" do
    get read_notifications_path
    assert_redirected_to new_user_session_path
  end

  test "you can view the history page even if no read notifications exist" do
    sign_in users(:business)

    get read_notifications_path
    assert_select "h3", "No read notifications"
  end

  test "you can view your past notifications if you have past (read) notifications" do
    sign_in users(:subscribed_business)
    notifications(:message_to_business).mark_as_read!

    get read_notifications_path

    assert_select "h1", "Read notifications"
  end

  test "you can mark all unread notifications as read" do
    sign_in users(:subscribed_business)
    notification = notifications(:message_to_business)

    refute notification.read?
    post read_notifications_path

    assert_redirected_to notifications_path
    assert notification.reload.read?
  end
end
