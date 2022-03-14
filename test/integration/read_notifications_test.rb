require "test_helper"

class ReadNotificationsTest < ActionDispatch::IntegrationTest
  include NotificationsHelper

  test "you must be signed in" do
    get read_notifications_path
    assert_redirected_to new_user_registration_path
  end

  test "you can view the history page even if no read notifications exist" do
    sign_in users(:with_business)

    get read_notifications_path
    assert_select "h3", "No read notifications"
  end

  test "you can view your past notifications if you have past (read) notifications" do
    user = users(:with_business)
    developer = developers(:available)
    sign_in user
    Message.create!(developer:, business: user.business, sender: developer, body: "Hello!")
    last_message_notification.mark_as_read!

    get read_notifications_path

    assert_select "h1", "Read notifications"
  end

  test "you can read all unread notifications" do
    user = users(:with_business)
    developer = developers(:available)
    sign_in user
    conversation = Conversation.create!(developer:, business: user.business)
    ["Hello!", "Available", "Let's talk"].each do |text|
      Message.create!(conversation:, sender: developer, body: text)
    end
    notifications = user.notifications.unread
    assert_equal 3, notifications.size

    post read_notifications_path

    assert_redirected_to notifications_path
    assert notifications.all?(&:read?)
    assert_equal 0, user.notifications.unread.size
  end
end
