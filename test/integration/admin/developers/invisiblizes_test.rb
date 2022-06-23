require "test_helper"

class Admin::Developers::InvisiblizesTest < ActionDispatch::IntegrationTest
  test "makes a developer invisible" do
    developer = developers(:one)
    sign_in users(:admin)

    post admin_developer_invisiblizes_path(developer)

    assert developer.reload.invisible?
  end

  test "must be an admin" do
    developer = developers(:one)
    sign_in users(:empty)

    post admin_developer_invisiblizes_path(developer)

    refute developer.reload.invisible?
  end
end
