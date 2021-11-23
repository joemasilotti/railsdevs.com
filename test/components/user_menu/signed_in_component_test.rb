require "test_helper"

class UserMenu::SignedInComponentTest < ViewComponent::TestCase
  include ActionDispatch::Routing::UrlFor
  include Rails.application.routes.url_helpers

  test "edit developer profile path" do
    user = users(:with_available_profile)
    render_inline UserMenu::SignedInComponent.new(user)
    assert_selector "a[href='#{edit_developer_path(user.developer)}']"
  end

  test "new developer profile path when the user doesn't have one" do
    user = users(:without_profile)
    render_inline UserMenu::SignedInComponent.new(user)
    assert_selector "a[href='#{new_developer_path}']"
  end
end
