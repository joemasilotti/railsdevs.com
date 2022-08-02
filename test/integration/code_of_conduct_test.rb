require "test_helper"

class CodeOfConductTest < ActionDispatch::IntegrationTest
  test "renders the markdown" do
    get page_path("conduct")

    assert_select "h1", text: "Code of conduct"
    assert_select "h2", text: "Our pledge"
  end
end
