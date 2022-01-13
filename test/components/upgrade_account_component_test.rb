require "test_helper"

class UpgradeAccountComponentTest < ViewComponent::TestCase
  test "renders the content if the user has an active business subscription" do
    render_inline(UpgradeAccountComponent.new(users(:with_business_conversation))) { "Content." }
    assert_text "Content."
    assert_no_text I18n.t(".upgrade_account_component.cta")
  end

  test "renders the CTA if not" do
    render_inline(UpgradeAccountComponent.new(users(:empty))) { "Content." }
    assert_text I18n.t(".upgrade_account_component.cta")
    assert_no_text "Content."
  end
end
