require "test_helper"

class Admin::Businesses::InvisiblizesTest < ActionDispatch::IntegrationTest
  test "makes a business invisible" do
    business = businesses(:one)
    sign_in users(:admin)

    post admin_business_invisiblizes_path(business)

    assert business.reload.invisible?
  end

  test "must be an admin" do
    business = businesses(:one)
    sign_in users(:empty)

    post admin_business_invisiblizes_path(business)

    refute business.reload.invisible?
  end
end
