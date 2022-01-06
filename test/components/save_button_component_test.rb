require "test_helper"

class SaveButtonComponentTest < ViewComponent::TestCase
  def test_component_renders_something_useful
    text = "Save"
    disable_with = "Processing"

    render_inline(SaveButtonComponent.new(text: text, disable_with: disable_with))

    assert_selector("span.show-when-enabled", text: text)
    assert_selector("span.show-when-disabled", text: disable_with)
    assert_selector("svg.show-when-disabled")
  end
end
