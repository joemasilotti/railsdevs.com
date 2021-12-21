require "test_helper"

class MessageTest < ActiveSupport::TestCase
  test "user is sender if they are the associated developer" do
    user = users(:with_developer_conversation)
    assert messages(:from_developer).sender?(user)
    refute messages(:from_business).sender?(user)
  end

  test "user is sender if they are the associated business" do
    user = users(:with_business_conversation)
    assert messages(:from_business).sender?(user)
    refute messages(:from_developer).sender?(user)
  end

  test "user is not the sender if they are neither the associated developer nor business" do
    user = users(:empty)
    refute messages(:from_developer).sender?(user)
  end

  test "message creation sends a notification to the recipient" do
    developer = developers(:available)
    business = businesses(:one)
    assert_changes "Notification.count", 1 do
      Message.create!(developer: developer, business: business, sender: business, body: "Hello!")
    end
    assert_equal Notification.last.recipient, developer
  end
end
