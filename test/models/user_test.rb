require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "conversations where the user is the developer" do
    user = users(:with_developer_conversation)
    assert_equal user.conversations, [conversations(:one)]
  end

  test "conversations where the user is the business" do
    user = users(:with_business_conversation)
    assert_equal user.conversations, [conversations(:one)]
  end

  test "blocked conversations are ignored" do
    user = users(:with_business_conversation)
    assert user.conversations.include?(conversations(:one))
    refute user.conversations.include?(conversations(:blocked))
  end
end
