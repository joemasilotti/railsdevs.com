require "test_helper"

class APIAuthenticatableTest < ActiveSupport::TestCase
  test "validating credentials" do
    assert_equal users(:empty), User.valid_credentials?("user@example.com", "password")
    assert_nil User.valid_credentials?("user@example.com", "invalid")
    assert_nil User.valid_credentials?("unknown@example.com", "password")
  end
end
