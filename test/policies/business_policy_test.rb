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
end
