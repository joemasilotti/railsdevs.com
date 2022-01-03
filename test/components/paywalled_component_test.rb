require "test_helper"

class PaywalledComponentTest < ViewComponent::TestCase
  test "should restrict paywall content" do
    user = users(:with_business)
    developer = developers(:available)

    render_inline(PaywalledComponent.new(user: user, paywalled: developer)) { "Test text" }
    assert_no_text "Test text"

    render_inline(PaywalledComponent.new(user: nil, paywalled: developer)) { "Test text" }
    assert_no_text "Test text"

    render_inline(PaywalledComponent.new(user: nil, paywalled: nil)) { "Test text" }
    assert_no_text "Test text"
  end

  test "should should show paywall content to customers" do
    user = users(:with_business_conversation)
    developer = developers(:available)
    render_inline(PaywalledComponent.new(user: user, paywalled: developer)) { "Test text" }

    assert_text "Test text"
  end

  test "should show paywall content to the owner" do
    user = users(:with_available_profile)
    developer = developers(:available)
    render_inline(PaywalledComponent.new(user: user, paywalled: developer)) { "Test text" }

    assert_text "Test text"
  end
end
