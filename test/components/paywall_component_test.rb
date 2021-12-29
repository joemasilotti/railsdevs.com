require "test_helper"

class PaywallComponentTest < ViewComponent::TestCase
  test "should restrict paywall content" do
    user = users(:with_business)
    render_inline(PaywallComponent.new(user: user)) { "Test text" }

    assert_no_text "Test text"
  end

  test "should should show paywall content to customers" do
    user = users(:with_business_conversation)
    render_inline(PaywallComponent.new(user: user)) { "Test text" }

    assert_text "Test text"
  end
end
