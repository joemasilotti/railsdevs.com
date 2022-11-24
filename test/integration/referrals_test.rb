require "test_helper"

class ReferralsTest < ActionDispatch::IntegrationTest
  test "the ref param is set to a cookie" do
    assert_nil cookies[:ref]
    get root_path(ref: "abc123")
    assert_equal "abc123", cookies[:ref]
  end

  test "no ref param doesn't clear existing cookies" do
    cookies[:ref] = "existing"
    get root_path(ref: "")
    assert_equal "existing", cookies[:ref]
  end

  test "new ref params overwrite existing cookies" do
    cookies[:ref] = "existing"
    get root_path(ref: "new")
    assert_equal "new", cookies[:ref]
  end
end
