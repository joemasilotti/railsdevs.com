require "test_helper"

module Users
  class PermissionTest < ActiveSupport::TestCase
    test "authorized with an active subscription" do
      user = users(:subscribed_business)
      resource = developers(:one)

      assert Permission.new(user, resource).authorized?
    end

    test "authorized when the owner of the resource" do
      user = users(:developer)
      resource = developers(:one)

      assert Permission.new(user, resource).authorized?
    end

    test "authorized when the public key is valid" do
      user = users(:empty)
      resource = developers(:one)
      public_key = resource.public_profile_key

      assert Permission.new(user, resource, public_key:).authorized?
    end

    test "unauthorized when the public key is invalid" do
      user = users(:empty)
      resource = developers(:one)
      public_key = "invalid-key"

      refute Permission.new(user, resource, public_key:).authorized?
    end

    test "always unauthorized with no user" do
      resource = developers(:one)

      refute Permission.new(nil, resource).authorized?
    end

    test "always unauthorized with no resource" do
      user = users(:empty)

      refute Permission.new(user, nil).authorized?
    end

    test "always unauthorized with no user nor resource" do
      refute Permission.new(nil, nil).authorized?
    end
  end
end
