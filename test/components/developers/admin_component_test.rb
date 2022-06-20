require "test_helper"

module Developers
  class AdminComponentTest < ViewComponent::TestCase
    test "renders for admins" do
      developer = developers(:one)

      render_inline AdminComponent.new(developer, user: users(:admin))
      assert_selector "button"

      render_inline AdminComponent.new(developer, user: developer.user)
      assert_no_selector "*"

      render_inline AdminComponent.new(developer, user: nil)
      assert_no_selector "*"
    end
  end
end
