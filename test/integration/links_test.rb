require "test_helper"

class LinksTest < ActionDispatch::IntegrationTest
  test "redirects to link" do
    sign_in users(:with_profile_one)
    developer = developers(:one)

    get developer_link_path(developer, "email")

    assert_redirected_to "mailto:#{developer.user.email}"
  end

  test "requires authentication" do
    developer = developers(:one)
    get developer_link_path(developer, "email")
    assert_redirected_to new_user_session_path
  end
end
