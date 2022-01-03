require "test_helper"

class DeveloperPrimaryActionComponentTest < ViewComponent::TestCase
  setup do
    @developer = developers(:available)
  end

  test "should show nothing by default" do
    render_inline DeveloperPrimaryActionComponent.new(user: nil, developer: @developer)

    refute_text "Hire me"
    refute_text "Edit"
  end

  test "should show edit to owner of profile" do
    user = users(:with_available_profile)
    render_inline DeveloperPrimaryActionComponent.new(user: user, developer: @developer)

    assert_text "Edit"
  end

  test "should show message button to business account" do
    user = users(:with_business)
    render_inline DeveloperPrimaryActionComponent.new(user: user, developer: @developer)

    assert_text "Hire me"
  end
end
