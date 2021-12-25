require "test_helper"

class ConversationTest < ActiveSupport::TestCase
  test "visible does not include ones blocked by the developer" do
    conversation = conversations(:one)
    assert Conversation.visible.include?(conversation)

    conversation.touch(:developer_blocked_at)
    refute Conversation.visible.include?(conversation)
  end

  test "visible does not include ones blocked by the business" do
    conversation = conversations(:one)
    assert Conversation.visible.include?(conversation)

    conversation.touch(:business_blocked_at)
    refute Conversation.visible.include?(conversation)
  end

  test "other recipient is the business when the user is the developer" do
    user = users(:with_developer_conversation)
    conversation = conversations(:one)
    assert_equal conversation.other_recipient(user), conversation.business
  end

  test "other recipient is the developer when the user is the business" do
    user = users(:with_business_conversation)
    conversation = conversations(:one)
    assert_equal conversation.other_recipient(user), conversation.developer
  end

  test "is blocked if blocked by the developer" do
    conversation = conversations(:one)
    refute conversation.blocked?

    conversation.touch(:developer_blocked_at)
    assert conversation.blocked?
  end

  test "is blocked if blocked by the business" do
    conversation = conversations(:one)
    refute conversation.blocked?

    conversation.touch(:business_blocked_at)
    assert conversation.blocked?
  end

  test "creating a conversation sends a notification to the admin" do
    assert_changes "Notification.count", 1 do
      Conversation.create!(developer: developers(:available), business: businesses(:one))
    end

    assert_equal Notification.last.type, NewConversationNotification.name
    assert_equal Notification.last.recipient, users(:admin)
  end
end
