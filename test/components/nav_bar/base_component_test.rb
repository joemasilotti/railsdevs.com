require "test_helper"

class NavBar::BaseComponentTest < ViewComponent::TestCase
  include ActionDispatch::Routing::UrlFor
  include Rails.application.routes.url_helpers
  include TurboNativeHelper

  test "links to developers, pricing, and about" do
    render_inline NavBar::BaseComponent.new(nil)

    assert_selector "a[href='#{developers_path}']"
    assert_selector "a[href='#{pricing_path}']"
    assert_selector "a[href='#{about_path}']"
  end

  test "links to developers and about on native apps" do
    turbo_native_request!
    render_inline NavBar::BaseComponent.new(nil)

    assert_selector "a[href='#{developers_path}']"
    refute_selector "a[href='#{pricing_path}']"
    assert_selector "a[href='#{about_path}']"
  end
end
