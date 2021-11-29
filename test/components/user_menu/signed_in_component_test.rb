require "test_helper"

class UserMenu::SignedInComponentTest < ViewComponent::TestCase
  include ActionDispatch::Routing::UrlFor
  include Rails.application.routes.url_helpers

  test "no developer or business, links to developer" do
    user = users(:without_profile)
    render_inline UserMenu::SignedInComponent.new(user)
    assert_selector "a[href='#{new_developer_path}']"
    assert_no_selector "a[href='#{new_business_path}']"
  end

  test "developer only, links to it" do
    user = users(:with_available_profile)
    render_inline UserMenu::SignedInComponent.new(user)
    assert_selector "a[href='#{new_developer_path}']"
    assert_no_selector "a[href='#{new_business_path}']"
  end

  test "business only, links to it" do
    user = users(:with_business)
    render_inline UserMenu::SignedInComponent.new(user)
    assert_no_selector "a[href='#{new_developer_path}']"
    assert_selector "a[href='#{new_business_path}']"
  end

  test "both developer and business, links to both" do
    user = users(:with_profile_and_business)
    render_inline UserMenu::SignedInComponent.new(user)
    assert_selector "a[href='#{new_developer_path}']"
    assert_selector "a[href='#{new_business_path}']"
  end
end
