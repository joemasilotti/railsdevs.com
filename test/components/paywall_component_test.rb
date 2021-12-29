require "test_helper"

class PaywallComponentTest < ViewComponent::TestCase
  test "should restrict paywall content" do
    user = users(:with_business)
    developer = developers(:available)
    render_inline(PaywallComponent.new(user: user, paywalled: developer)) { "Test text" }

    assert_no_text "Test text"
  end

  test "should should show paywall content to customers" do
    user = users(:with_business_conversation)
    developer = developers(:available)
    render_inline(PaywallComponent.new(user: user, paywalled: developer)) { "Test text" }

    assert_text "Test text"
  end

  test "should show paywall content to the owner" do
    user = users(:with_available_profile)
    developer = developers(:available)
    render_inline(PaywallComponent.new(user: user, paywalled: developer)) { "Test text" }

    assert_text "Test text"
  end

  test "paywalls content when detecting ownership on bad target" do
    user = users(:with_available_profile)
    developer = "Bad input"
    render_inline(PaywallComponent.new(user: user, paywalled: developer)) { "Test text" }

    assert_no_text "Test text"
  end
end
