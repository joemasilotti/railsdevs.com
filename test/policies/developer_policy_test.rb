require "test_helper"

class DeveloperPolicyTest < ActiveSupport::TestCase
  test "can create and update their own developerprofile" do
    user = users(:one)
    developer = developers(:one)

    assert DeveloperPolicy.new(user, developer).create?
    assert DeveloperPolicy.new(user, developer).update?
  end

  test "cannot create nor update another's developerprofile" do
    user = users(:one)
    developer = developers(:two)

    refute DeveloperPolicy.new(user, developer).create?
    refute DeveloperPolicy.new(user, developer).update?
  end
end
