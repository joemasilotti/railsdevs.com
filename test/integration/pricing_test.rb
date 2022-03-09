require "test_helper"

class PricingTest < ActionDispatch::IntegrationTest
  test "sees the pricing page" do
    get pricing_path

    assert_select "h1", text: I18n.t("pricing.show.title")
  end
end
