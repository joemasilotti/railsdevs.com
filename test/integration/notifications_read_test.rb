require "test_helper"

class ReadNotificationsTest < ActionDispatch::IntegrationTest
  test "you must be signed in" do
    get notifications_read_index_path
    assert_redirected_to new_user_registration_path
  end

  test "you can view the history page even if no read notifications exist" do
    sign_in users(:with_business)

    get notifications_read_index_path
    assert_select "h3", "No read notifications"
  end

  test "you can view your past notifications if you have past (read) notifications" do
    user = users(:with_business)
    developer = developers(:available)
    sign_in user
    Message.create!(developer: developer, business: user.business, sender: developer, body: "Hello!")
    notification = Notification.last

    get conversation_path(notification.conversation)

    get notifications_read_index_path
    assert_select "h1", "Read notifications"
  end
end
