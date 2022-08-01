require "test_helper"

class UserBusinessRoleTest < ActiveSupport::TestCase
  test "user business roles where the user is an admin" do
    user = users(:subscribed_business)
    business = businesses(:subscriber)
    assert_equal user.user_business_roles.where(business:), [user_business_roles(:admin)]
  end
  test "user business roles where the user is a member" do
    user = users(:developer)
    business = businesses(:subscriber)
    assert_equal user.user_business_roles.where(business:), [user_business_roles(:member)]
  end
end
