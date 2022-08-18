require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "conversations where the user is the developer" do
    user = users(:prospect_developer)
    assert_equal user.conversations, [conversations(:one)]
  end

  test "conversations where the user is the business" do
    user = users(:subscribed_business)
    assert_equal user.conversations, [conversations(:one)]
  end

  test "blocked conversations are ignored" do
    user = users(:subscribed_business)
    assert user.conversations.include?(conversations(:one))

    conversations(:one).touch(:developer_blocked_at)
    refute user.conversations.include?(conversations(:one))
  end

  test "customer name for Pay" do
    user = users(:business)
    assert_equal user.pay_customer_name, businesses(:one).name

    user = users(:empty)
    assert_nil user.pay_customer_name
  end

  test "searching via email" do
    assert_equal [users(:empty)], User.filter_by_email("user@EXAMPLE.com")
    assert_equal [users(:admin)], User.filter_by_email("admin@")
    assert_empty User.filter_by_email("joe")
  end
end
