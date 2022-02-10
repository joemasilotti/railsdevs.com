require "test_helper"

class AlternateLinksComponentTest < ViewComponent::TestCase
  test "renders a x-default link for the current locale" do
    with_request_url "/developers" do
      render_inline(AlternateLinksComponent.new)
      assert_selector "link[rel=alternate][href='http://test.host/developers'][hreflang=x-default]", visible: false
    end
  end

  test "renders links for other locales" do
    with_request_url "/developers" do
      render_inline(AlternateLinksComponent.new)
      (I18n.available_locales - [I18n.locale]).each do |locale|
        assert_selector "link[rel=alternate][href='http://test.host/#{locale}/developers'][hreflang=#{locale}]", visible: false
      end
    end
  end

  def assert_alternate_link
    assert_selector("link[rel=alternate]")
  end
end
