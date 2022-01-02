require "test_helper"

class DeveloperPolicyTest < ActiveSupport::TestCase
  test "update their own developer profile" do
    user = users(:with_available_profile)
    assert DeveloperPolicy.new(user, user.developer).update?
  end

  test "cannot update another's developer profile" do
    user = users(:with_available_profile)
    developer = developers(:unavailable)

    refute DeveloperPolicy.new(user, developer).update?
  end
end
