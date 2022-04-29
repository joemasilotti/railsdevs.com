require "test_helper"

class APIAuthenticatableTest < ActiveSupport::TestCase
  test "validating credentials" do
    assert_equal users(:empty), User.valid_credentials?("user@example.com", "password")
    assert_nil User.valid_credentials?("user@example.com", "invalid")
    assert_nil User.valid_credentials?("unknown@example.com", "password")
  end

  test "tokens don't conflict with others" do
    user = users(:empty)
    other_user = users(:developer)

    tokens = [other_user.authentication_token, "new-token"]
    Devise.stub(:friendly_token, proc { tokens.shift }) do
      user.authentication_token = nil
      user.save!
    end

    assert_equal user.reload.authentication_token, "new-token"
  end
end
