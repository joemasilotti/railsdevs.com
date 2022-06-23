require "test_helper"

module Businesses
  class AdminComponentTest < ViewComponent::TestCase
    test "renders for admins" do
      business = businesses(:one)

      render_inline AdminComponent.new(business, user: users(:admin))
      assert_selector "button"

      render_inline AdminComponent.new(business, user: business.user)
      assert_no_selector "*"

      render_inline AdminComponent.new(business, user: nil)
      assert_no_selector "*"
    end
  end
end
