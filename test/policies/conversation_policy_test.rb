require 'test_helper'

class ConversationPolicyTest < ActiveSupport::TestCase
  test "returns work leads for developers" do
    skip("Implementing")
    policy = ConversationPolicy.new(user, conversation).policy_scope(Conversation)
  end

  test "returns company leads for developers" do
    skip("Implementing")
    policy = ConversationPolicy.new(user, conversation).policy_scope(Conversation)
  end
end
