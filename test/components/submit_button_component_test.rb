require "test_helper"

class SubmitButtonComponentTest < ViewComponent::TestCase
  def test_component_renders_something_useful
    text = "Save"
    disable_with = "Updating..."

    render_inline(SubmitButtonComponent.new(text: text, disable_with: disable_with))

    assert_selector("span.show.group-disabled\\:hidden", text: text)
    assert_selector("span.hidden.group-disabled\\:inline", text: disable_with)
    assert_selector("svg.hidden.group-disabled\\:inline")
  end
end
