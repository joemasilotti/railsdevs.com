require "test_helper"

class BusinessPolicyTest < ActiveSupport::TestCase
  test "update their own business profile" do
    user = users(:with_business)
    assert BusinessPolicy.new(user, user.business).update?
  end

  test "cannot update another's business profile" do
    user = users(:empty)
    business = businesses(:one)

    refute BusinessPolicy.new(user, business).update?
  end

  test "developer notifications are permitted for active business subscriptions" do
    user = users(:with_business)
    policy = BusinessPolicy.new(user, user.business)
    refute_includes policy.permitted_attributes, :developer_notifications

    user = users(:with_business_conversation)
    policy = BusinessPolicy.new(user, user.business)
    assert_includes policy.permitted_attributes, :developer_notifications
  end
end
