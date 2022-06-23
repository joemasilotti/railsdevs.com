require "test_helper"

class Admin::Businesses::InvisiblizesTest < ActionDispatch::IntegrationTest
  test "must be an admin" do
    sign_in users(:admin)
    post admin_business_invisiblizes_path(businesses(:one))
    assert_redirected_to root_path
  end

  test "makes a developer invisible" do
    business = businesses(:one)
    sign_in users(:admin)
    post admin_business_invisiblizes_path(business)
    assert business.reload.invisible?
  end
end
