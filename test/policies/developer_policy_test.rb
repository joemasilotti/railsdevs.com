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

  test "can create a developer profile if they do not already have one" do
    user = users(:without_profile)
    developer = user.developer

    assert DeveloperPolicy.new(user, developer).create?
  end

  test "cannot create a developer profile if they already have one" do
    user = users(:with_available_profile)
    developer = user.developer

    refute DeveloperPolicy.new(user, developer).create?
  end

  test "raises when instantiating a new developer when one exists" do
    user = users(:with_available_profile)

    assert_raises(DeveloperPolicy::AlreadyExists) do
      DeveloperPolicy.new(user, Developer.new).new?
    end
  end
end
