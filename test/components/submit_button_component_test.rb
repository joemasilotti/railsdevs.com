require "test_helper"

class SubmitButtonComponentTest < ViewComponent::TestCase
  test "should render enabled and disabled button states" do
    text = "Save"
    disable_with = "Updating..."

    render_inline(SubmitButtonComponent.new(text:, disable_with:))

    assert_selector("span.show.group-disabled\\:hidden", text:)
    assert_selector("span.hidden.group-disabled\\:inline", text: disable_with)
    assert_selector("svg.hidden.group-disabled\\:inline")
  end
end
