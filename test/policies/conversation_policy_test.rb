require "test_helper"

class ConversationPolicyTest < ActiveSupport::TestCase
  setup do
    @developer = developers(:available)
  end

  test "create a new conversation" do
    user = users(:with_business)
    conversation = Conversation.new(developer: @developer, business: user.business)
    assert ConversationPolicy.new(user, conversation).create?
  end

  test "cannot create a new conversation if no business" do
    user = users(:empty)
    conversation = Conversation.new(developer: @developer, business: user.business)
    assert_raises ConversationPolicy::MissingBusiness do
      ConversationPolicy.new(user, conversation).create?
    end
  end

  test "cannot create a new conversation if one already exists" do
    user = users(:with_business)
    conversation = Conversation.create!(developer: @developer, business: user.business)
    assert_raises ConversationPolicy::AlreadyExists do
      ConversationPolicy.new(user, conversation).create?
    end
  end

  test "cannot view a conversation if no business" do
    user = users(:empty)
    conversation = Conversation.create!(developer: @developer, business: businesses(:one))
    assert_raises ConversationPolicy::MissingBusiness do
      ConversationPolicy.new(user, conversation).create?
    end
  end

  test "can view a conversation" do
    user = users(:with_business)
    conversation = Conversation.create!(developer: @developer, business: user.business)
    assert ConversationPolicy.new(user, conversation).show?
  end
end
