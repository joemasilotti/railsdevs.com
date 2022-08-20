require "test_helper"

class EmptyStateComponentTest < ViewComponent::TestCase
  test "Renders the title, body and icon" do
    title = "No notifications"
    body = "Nothing to see"

    render_inline EmptyStateComponent.new(title, "clock", body:)

    assert_selector("h3", text: title)
    assert_selector("p", text: body)
    assert_selector "svg[title='Clock']"
  end
end
