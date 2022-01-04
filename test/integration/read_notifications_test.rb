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
    Message.create!(developer: developer, business: user.business, sender: developer, body: "Hello!")
    last_message_notification.mark_as_read!

    get read_notifications_path

    assert_select "h1", "Read notifications"
  end
end
