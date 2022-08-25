require "test_helper"

class BusinessPolicyTest < ActiveSupport::TestCase
  test "update their own business profile" do
    user = users(:business)
    assert BusinessPolicy.new(user, user.business).update?
  end

  test "cannot update another's business profile" do
    user = users(:empty)
    business = businesses(:one)

    refute BusinessPolicy.new(user, business).update?
  end

  test "developer notifications are permitted for active business subscriptions" do
    user = users(:business)
    policy = BusinessPolicy.new(user, user.business)
    refute_includes policy.permitted_attributes, :developer_notifications

    user = users(:subscribed_business)
    policy = BusinessPolicy.new(user, user.business)
    assert_includes policy.permitted_attributes, :developer_notifications
  end

  test "view their own invisible business profile" do
    business = businesses(:one)
    business.update!(invisible: true)
    assert BusinessPolicy.new(business.user, business).show?
  end

  test "cannot view another's invisible business profile" do
    user = users(:empty)
    business = businesses(:one)
    business.update!(invisible: true)

    refute BusinessPolicy.new(user, business).show?
  end

  test "admin can view another's invisible business profile" do
    user = users(:admin)
    business = businesses(:one)
    business.update!(invisible: true)

    assert BusinessPolicy.new(user, business).show?
  end
end
