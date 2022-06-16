require "test_helper"

class NewMessageNotificationTest < ActiveSupport::TestCase
  test "implements required methods for iOS notifications" do
    message = messages(:from_business)
    conversation = conversations(:one)

    notification = NewMessageNotification.with(message:, conversation:)

    assert_respond_to notification, "title"
    assert_respond_to notification, "ios_subject"
    assert_respond_to notification, "url"
  end
end
