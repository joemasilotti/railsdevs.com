require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "has developer profile?" do
    user = users(:without_profile)

    assert_not user.has_developer_profile?

    user = users(:with_available_profile)

    assert user.has_developer_profile?
  end
end
