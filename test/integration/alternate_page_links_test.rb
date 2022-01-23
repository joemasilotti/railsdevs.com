require "test_helper"

class AlternatePageLinksTest < ActionDispatch::IntegrationTest
  test "all available locales are shown in <head> with correct hreflang" do
    get root_path(locale: I18n.default_locale)
    assert_select "head link[href='http://www.example.com/'][hreflang='x-default']"

    other_locales = I18n.available_locales - [I18n.default_locale]
    other_locales.each do |locale|
      assert_select "head link[href='http://www.example.com/#{locale}'][hreflang='#{locale}']"
    end
  end
end
