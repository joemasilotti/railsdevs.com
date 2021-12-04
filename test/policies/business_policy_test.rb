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

  test "can create a business profile if they do not already have one" do
    user = users(:empty)
    business = user.business

    assert BusinessPolicy.new(user, business).create?
  end

  test "cannot create a business profile if they already have one" do
    user = users(:with_business)
    business = user.business

    refute BusinessPolicy.new(user, business).create?
  end

  test "raises when instantiating a new business when one exists" do
    user = users(:with_business)

    assert_raises(BusinessPolicy::AlreadyExists) do
      BusinessPolicy.new(user, Business.new).new?
    end
  end
end
