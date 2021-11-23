require "test_helper"

class UserMenu::BaseComponentTest < ViewComponent::TestCase
  test "renders the signed in component" do
    user = users(:with_available_profile)
    render_inline UserMenu::BaseComponent.new(user)
    assert_text "Open user menu"
  end

  test "renders the signed out component" do
    render_inline UserMenu::BaseComponent.new(nil)
    assert_text "Sign in"
  end
end
