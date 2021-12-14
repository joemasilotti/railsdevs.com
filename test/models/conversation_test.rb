require "test_helper"

class ConversationTest < ActiveSupport::TestCase
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
end
