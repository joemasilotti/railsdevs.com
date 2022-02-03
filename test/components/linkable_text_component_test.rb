require "test_helper"

class LinkableTextComponentTest < ViewComponent::TestCase
  test "renders a link if URL is given, with options" do
    render_inline LinkableTextComponent.new("click me", url: "https://google.com", class: "underline")
    assert_selector "a.underline[href='https://google.com']", text: "click me"
  end

  test "renders the text if no URL is given" do
    render_inline LinkableTextComponent.new("no link")
    assert_text "no link"
    assert_no_selector "a"
  end
end
