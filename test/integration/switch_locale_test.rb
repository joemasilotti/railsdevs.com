require "test_helper"

class SwitchLocaleTest < ActionDispatch::IntegrationTest
  test "I18n.locale will depends on the locale of urls" do
    [:en, :"zh-TW"].each do |locale|
      get root_path(locale: locale)
      assert I18n.locale.to_s == locale.to_s
    end
  end

  test "Visit urls with an unavailable locale will fallback to English" do
    assert_raises ActionController::RoutingError do
      get root_path(locale: "Klingon")
    end
    assert I18n.locale == :en
  end
end