require 'test_helper'

class ConversationPolicyTest < ActiveSupport::TestCase
  test "returns work leads for developers" do
    user = users(:with_available_profile)
    scope = Pundit.policy_scope(user, Conversation)

    assert_equal user.work_leads, scope
  end

  test "returns company leads for developers" do
    user = users(:client_with_conversation)
    scope = Pundit.policy_scope(user, Conversation)

    assert_equal user.hiring_leads, scope
  end
end
