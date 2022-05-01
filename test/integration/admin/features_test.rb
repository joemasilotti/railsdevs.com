require "test_helper"

class Admin::FeaturesTest < ActionDispatch::IntegrationTest
  test "must be an admin" do
    sign_in users(:admin)
    post admin_developer_features_path(developers(:one))
    assert_redirected_to developers_path
  end

  test "features the developer" do
    developer = developers(:one)
    sign_in users(:admin)
    post admin_developer_features_path(developer)
    assert_not_nil developer.reload.featured_at
  end
end
