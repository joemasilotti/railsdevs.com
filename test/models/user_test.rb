require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "when the user is admin" do
    user = users(:admin)

    assert user.admin?
  end

  test "when the user is not admin" do
    user = users(:with_profile_one)

    assert_equal false, user.admin?
  end
end
