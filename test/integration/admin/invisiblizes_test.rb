require "test_helper"

class Admin::InvisiblizesTest < ActionDispatch::IntegrationTest
  test "must be an admin" do
    sign_in users(:admin)
    post admin_developer_invisiblizes_path(developers(:one))
    assert_redirected_to developers_path
  end

  test "makes a developer invisible" do
    developer = developers(:one)
    sign_in users(:admin)
    post admin_developer_invisiblizes_path(developer)
    assert developer.reload.invisible?
  end
end
