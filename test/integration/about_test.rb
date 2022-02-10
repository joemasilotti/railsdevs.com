require "test_helper"

class AboutTest < ActionDispatch::IntegrationTest
  test "renders both sections of markdown" do
    get about_path

    assert_select "h3", "Empowering the developer"
    assert_select "li", "Empowering the independent developer"
  end

  test "renders translated versions of the markdown" do
    get about_path(locale: "pt-BR")

    assert_select "h3", "Empoderar desenvolvedores"
    assert_select "li", "Empoderar desenvolvedores independentes"
  end

  test "defaults to English translation" do
    get about_path(locale: "zh-TW")

    assert_select "h3", "Empowering the developer"
    assert_select "li", "Empowering the independent developer"
  end
end
