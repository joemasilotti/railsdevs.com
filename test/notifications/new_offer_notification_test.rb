require "test_helper"

class NewOfferNotificationTest < ActiveSupport::TestCase
  test "implements required methods for iOS notifications" do
    offer = offers(:one)

    notification = NewOfferNotification.with(offer:, conversation: offer.conversation)

    assert_respond_to notification, "title"
    assert_respond_to notification, "ios_subject"
    assert_respond_to notification, "url"
  end
end
