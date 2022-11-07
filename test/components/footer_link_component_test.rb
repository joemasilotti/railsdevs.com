require "test_helper"

class FooterLinkComponentTest < ViewComponent::TestCase
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::TagHelper

  test "renders link" do
    render_inline(FooterLinkComponent.new(link: about_path)) { "About" }

    assert_selector "a[href='/about']"
    assert_text "About"
  end

  test "external links target blank" do
    render_inline(FooterLinkComponent.new(link: "https://github.com/joemasilotti/railsdevs.com", external: true)) do
      "Open source"
    end

    assert_selector "a[href='https://github.com/joemasilotti/railsdevs.com'][target='_blank']"
    assert_text "Open source"
  end

  test "renders nested content" do
    render_inline(FooterLinkComponent.new(link: "https://twitter.com/joemasilotti", external: true)) do
      tag.span "Twitter", id: "test"
    end

    assert_selector "a[href='https://twitter.com/joemasilotti'][target='_blank']"
    assert_selector "span#test", text: "Twitter"
  end
end
