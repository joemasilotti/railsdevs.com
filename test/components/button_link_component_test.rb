require "test_helper"

class ButtonLinkComponentTest < ViewComponent::TestCase
  def test_button_link_component_renders_link_styled_button
    render_inline(ButtonLinkComponent.new("mailto:hello@example.com")) { "Send" }

    assert_no_selector('svg')
    assert_selector("span", text: 'Send')
  end

  def test_button_link_component_renders_with_icon
    render_inline(ButtonLinkComponent.new("/action", icon: "mail")) { "Send" }

    assert_selector('svg')
  end
end
