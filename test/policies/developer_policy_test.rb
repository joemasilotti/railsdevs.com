require "test_helper"

class DeveloperPolicyTest < ActiveSupport::TestCase
  test "update their own developer profile" do
    user = users(:with_available_profile)
    developer = developers(:available)

    assert DeveloperPolicy.new(user, developer).update?
  end

  test "cannot update another's developer profile" do
    user = users(:with_available_profile)
    developer = developers(:unavailable)

    refute DeveloperPolicy.new(user, developer).update?
  end

  test "can create developer profile if they do not already have one" do
    user = users(:without_profile)
    developer = user.developer

    assert DeveloperPolicy.new(user, developer).create?
  end

  test "cannot create developer profile for self if they already have one" do
    user = users(:with_available_profile)
    developer = user.developer

    refute DeveloperPolicy.new(user, developer).create?
  end
end
