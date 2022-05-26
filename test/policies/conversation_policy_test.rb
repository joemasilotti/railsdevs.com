require "test_helper"

class ConversationPolicyTest < ActiveSupport::TestCase
  setup do
    @conversation = conversations(:one)
  end

  test "admins can view any conversation" do
    user = users(:admin)
    assert ConversationPolicy.new(@conversation, user:).show?
  end

  test "blocked conversations can't be viewed" do
    @conversation.touch(:developer_blocked_at)

    user = @conversation.business.user
    refute ConversationPolicy.new(@conversation, user:).show?

    user = @conversation.developer.user
    refute ConversationPolicy.new(@conversation, user:).show?
  end

  test "folks involved in the conversation can view it" do
    user = @conversation.business.user
    assert ConversationPolicy.new(@conversation, user:).show?

    user = @conversation.developer.user
    assert ConversationPolicy.new(@conversation, user:).show?

    user = users(:empty)
    refute ConversationPolicy.new(@conversation, user:).show?
  end
end
