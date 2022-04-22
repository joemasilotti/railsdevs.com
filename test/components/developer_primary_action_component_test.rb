require "test_helper"

class DeveloperPrimaryActionComponentTest < ViewComponent::TestCase
  setup do
    @developer = developers(:one)
  end

  test "should show nothing by default" do
    render_inline DeveloperPrimaryActionComponent.new(user: nil, developer: @developer)

    assert_text "Hire me"
    refute_text "Edit"

    user = users(:business)
    render_inline DeveloperPrimaryActionComponent.new(user:, developer: @developer)

    assert_text "Hire me"
  end

  test "should show edit to owner of profile" do
    user = users(:developer)
    render_inline DeveloperPrimaryActionComponent.new(user:, developer: @developer)

    assert_text "Edit"
  end

  test "should show invisiblize to an admin" do
    user = users(:admin)
    render_inline DeveloperPrimaryActionComponent.new(user:, developer: @developer)

    assert_text "Invisiblize"
  end
end
