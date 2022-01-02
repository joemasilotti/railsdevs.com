require "test_helper"

class NotificationsTest < ActionDispatch::IntegrationTest
  test "you must be signed in" do
    get notifications_path
    assert_redirected_to new_user_registration_path
  end

  test "you can view the new notifications page even if none exist" do
    sign_in users(:with_business)

    get notifications_path
    assert_select "h3", "No new notifications"
  end

  test "you can view your new notifications if you have new (unread) notifications" do
    user = users(:with_business)
    developer = developers(:available)
    sign_in user
    create_message!(developer: developer, business: user.business)

    get notifications_path
    assert_select "h1", "New notifications"
  end

  test "viewing a notification marks it as read and redirects" do
    user = users(:with_business)
    developer = developers(:available)
    sign_in user
    message = create_message!(developer: developer, business: user.business)
    notification = Notification.last

    refute notification.reload.read?
    get notification_path(notification)

    assert_redirected_to conversation_path(message.conversation)
    assert notification.reload.read?
  end

  test "redirects to your notifications if the notification doesn't have a URL" do
    user = users(:admin)
    sign_in user
    Conversation.create!(developer: developers(:available), business: businesses(:one))
    notification = Notification.last

    get notification_path(notification)

    assert_redirected_to notifications_path
  end

  def create_message!(developer:, business:)
    Message.create!(developer: developer, business: business, sender: developer, body: "Hello!")
  end
end
