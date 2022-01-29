require "test_helper"

class SwitchLocaleTest < ActionDispatch::IntegrationTest
  test "I18n.locale will depends on the locale of urls" do
    [:en, :"zh-TW"].each do |locale|
      get root_path(locale:)
      assert I18n.locale.to_s == locale.to_s
    end
  end

  test "Visit urls with an unavailable locale will return 404" do
    assert_raises ActionController::RoutingError do
      get root_path(locale: "Klingon")
    end
  end

  test "links to all locales will show, except the current locale" do
    current_locale = :"zh-TW"
    get root_path(locale: current_locale)
    assert I18n.locale == current_locale

    other_locales = I18n.available_locales - [current_locale]
    other_locales.each do |locale|
      if locale == I18n.default_locale
        assert_select "a[href='/']", text: language_name_of(locale)
      else
        assert_select "a[href='/#{locale}']", text: language_name_of(locale)
      end
    end
    assert_select "a[href='/#{current_locale}']", count: 0, text: language_name_of(current_locale)
  end

  def language_name_of(locale)
    I18n.t("shared.footer.language_name_of_locale", locale:)
  end
end
