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
    Message.create!(developer: developer, business: user.business, sender: developer, body: "Hello!")

    get notifications_path
    assert_select "h1", "New notifications"
  end

  test "you can mark new notifications as read, and they will no longer appear on the page" do
    user = users(:with_business)
    developer = developers(:available)
    sign_in user
    Message.create!(developer: developer, business: user.business, sender: developer, body: "Hello!")
    notification = Notification.last

    get conversation_path(notification.conversation)

    get notifications_path
    assert_select "h3", "No new notifications"
  end
end
