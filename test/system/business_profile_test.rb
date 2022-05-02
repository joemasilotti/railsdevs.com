require "application_system_test_case"

class BusinessProfileTest < ApplicationSystemTestCase
  test "users can log in" do
    business = businesses(:one)

    login_as(business.user)

    visit business_path(id: business.id)
  end
end
