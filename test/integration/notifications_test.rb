require "test_helper"

class NotificationsTest < ActionDispatch::IntegrationTest
  include NotificationsHelper

  test "you must be signed in" do
    get notifications_path
    assert_redirected_to new_user_session_path
  end

  test "redirects to notification if signed in" do
    sign_in users(:subscribed_business)
    notification = notifications(:message_to_business)
    conversation = conversations(:one)

    get notification_path(notification)
    assert_redirected_to conversation_path(conversation)
  end

  test "you can view the new notifications page even if none exist" do
    sign_in users(:business)
    get notifications_path
    assert_select "h3", "No new notifications"
  end

  test "you can view your new notifications if you have new (unread) notifications" do
    sign_in users(:subscribed_business)
    get notifications_path
    assert_select "h1", "New notifications"
  end

  test "viewing a notification marks it as read and redirects" do
    sign_in users(:subscribed_business)
    notification = notifications(:message_to_business)
    conversation = conversations(:one)

    refute notification.reload.read?
    get notification_path(notification)

    assert_redirected_to conversation_path(conversation)
    assert notification.reload.read?
  end
end
