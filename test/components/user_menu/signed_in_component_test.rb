require "test_helper"

class UserMenu::SignedInComponentTest < ViewComponent::TestCase
  include ActionDispatch::Routing::UrlFor
  include Rails.application.routes.url_helpers

  test "links to business" do
    user = users(:with_business)
    render_inline UserMenu::SignedInComponent.new(user)
    assert_selector "a[href='#{new_business_path}']"
  end

  test "doesn't link to business" do
    user = users(:with_available_profile)
    render_inline UserMenu::SignedInComponent.new(user)
    assert_no_selector "a[href='#{new_business_path}']"
  end
end
