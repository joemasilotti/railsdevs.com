require "test_helper"

class ConversationPolicyTest < ActiveSupport::TestCase
  setup do
    @user = users(:with_business)
    @developer = developers(:available)
  end

  test "can view their own conversation" do
    business = @user.business
    conversation = Conversation.create!(developer: @developer, business: business)
    assert ConversationPolicy.new(@user, conversation).show?
  end

  test "cannot view another business' conversation" do
    business = businesses(:two)
    conversation = Conversation.create!(developer: @developer, business: business)
    refute ConversationPolicy.new(@user, conversation).show?
  end
end
