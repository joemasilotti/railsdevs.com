require "test_helper"

class Marketing::TextCardComponentTest < ViewComponent::TestCase
  test "renders title with text content" do
    render_inline Marketing::TextCardComponent.new(title: "Test", text: "Blah blah")

    assert_selector "h3", text: "Test"
    assert_selector "p", text: "Blah blah"
  end

  test "xl_title adds widens the h3 tag" do
    render_inline Marketing::TextCardComponent.new(title: "Test", text: "Blah blah", xl_title: true)

    assert_selector "h3.w-64", text: "Test"
  end
end
