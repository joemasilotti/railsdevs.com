require "test_helper"

class AlternatePageLinksTest < ActionDispatch::IntegrationTest
  test "All available locales are shown in <head> with correct hreflang" do
    get root_path(locale: "en")
    assert_select "head link[href='http://www.example.com/en'][hreflang='x-default']"

    other_locales = I18n.available_locales - [:en]
    other_locales.each do |locale|
      assert_select "head link[href='http://www.example.com/#{locale}'][hreflang='#{locale}']"
    end
  end
end