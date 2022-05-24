require "test_helper"

class Messaging::MessageTest < ActiveSupport::TestCase
  include NotificationsHelper

  test "must have a business profile" do
    user = users(:empty)

    result = Messaging::Message.new(user, developer_id:).build_message

    refute result.success?
    assert result.missing_business?
  end

  test "must have an active business subscription" do
    user = users(:business)

    result = Messaging::Message.new(user, developer_id:).build_message

    refute result.success?
    refute result.missing_business?
    assert result.invalid_subscription?
  end

  test "a business can create a new conversation" do
    user = users(:subscribed_business)

    assert_difference ["Message.count", "Conversation.count"], 1 do
      assert_sends_notification NewConversationNotification do
        result = Messaging::Message.new(user, developer_id:).send_message({body: "Hi!"})
        assert result.success?
        assert_equal Conversation.last, result.conversation
        assert_equal Message.last, result.cold_message.message
      end
    end
  end

  test "a business can't create an existing conversation" do
    user = users(:subscribed_business)
    Conversation.create!(developer_id:, business: user.business)

    assert_no_difference ["Message.count", "Conversation.count"] do
      result = Messaging::Message.new(user, developer_id:).send_message({body: "Hi!"})
      refute result.success?
      assert result.existing_conversation?
    end
  end

  # TODO: test "a part-time subscription can't message developers seeking only full-time roles"

  test "invalid messages" do
    user = users(:subscribed_business)

    assert_no_difference "Message.count" do
      assert_no_difference "Conversation.count" do
        result = Messaging::Message.new(user, developer_id:).send_message({body: nil})
        refute result.success?
        assert result.failure?
      end
    end
  end

  def developer_id
    developers(:one).id
  end
end
