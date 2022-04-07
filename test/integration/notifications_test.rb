require "test_helper"

class NotificationsTest < ActionDispatch::IntegrationTest
  include NotificationsHelper

  test "you must be signed in" do
    get notifications_path
    assert_redirected_to new_user_session_path
  end

  test "redirects to conversation if already sign in" do
    user = users(:business)
    developer = developers(:one)
    sign_in user
    message = create_message!(developer:, business: user.business)
    notification = last_message_notification

    get notification_path(notification)
    assert_redirected_to conversation_path(message.conversation)
  end

  test "you can view the new notifications page even if none exist" do
    sign_in users(:business)

    get notifications_path
    assert_select "h3", "No new notifications"
  end

  test "you can view your new notifications if you have new (unread) notifications" do
    user = users(:business)
    developer = developers(:one)
    sign_in user
    create_message!(developer:, business: user.business)

    get notifications_path
    assert_select "h1", "New notifications"
  end

  test "viewing a notification marks it as read and redirects" do
    user = users(:business)
    developer = developers(:one)
    sign_in user
    message = create_message!(developer:, business: user.business)
    notification = last_message_notification

    refute notification.reload.read?
    get notification_path(notification)

    assert_redirected_to conversation_path(message.conversation)
    assert notification.reload.read?
  end

  def create_message!(developer:, business:)
    Message.create!(developer:, business:, sender: developer, body: "Hello!")
  end
end
