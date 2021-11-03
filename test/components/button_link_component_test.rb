require "test_helper"

class ButtonLinkComponentTest < ViewComponent::TestCase
  test "link styled button" do
    render_inline(ButtonLinkComponent.new("mailto:hello@example.com")) { "Send" }

    assert_no_selector("svg")
    assert_selector("span", text: "Send")
  end

  test "with_icon" do
    render_inline(ButtonLinkComponent.new("/action", icon: "mail")) { "Send" }

    assert_selector("svg")
  end
end
