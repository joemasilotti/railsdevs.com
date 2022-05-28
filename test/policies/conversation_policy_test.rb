require "test_helper"

class ConversationPolicyTest < ActiveSupport::TestCase
  setup do
    @conversation = conversations(:one)
  end

  test "admins can view any conversation" do
    user = users(:admin)
    assert ConversationPolicy.new(user, @conversation).show?
  end

  test "blocked conversations can't be viewed" do
    @conversation.touch(:developer_blocked_at)

    user = @conversation.business.user
    refute ConversationPolicy.new(user, @conversation).show?

    user = @conversation.developer.user
    refute ConversationPolicy.new(user, @conversation).show?
  end

  test "folks involved in the conversation can view it" do
    user = @conversation.business.user
    assert ConversationPolicy.new(user, @conversation).show?

    user = @conversation.developer.user
    assert ConversationPolicy.new(user, @conversation).show?

    user = users(:empty)
    refute ConversationPolicy.new(user, @conversation).show?
  end
end
