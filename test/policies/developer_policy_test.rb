require "test_helper"

class DeveloperPolicyTest < ActiveSupport::TestCase
  test "update their own developerprofile" do
    user = users(:one)
    developer = developers(:one)

    assert DeveloperPolicy.new(user, developer).update?
  end

  test "cannot update another's developerprofile" do
    user = users(:one)
    developer = developers(:two)

    refute DeveloperPolicy.new(user, developer).update?
  end

  test "can create developerprofile if they do not already have one" do
    user = users(:three)
    developer = user.developer

    assert DeveloperPolicy.new(user, developer).create?
  end

  test "cannot create developerprofile for self if they already have one" do
    user = users(:one)
    developer = user.developer

    refute DeveloperPolicy.new(user, developer).create?
  end
end
