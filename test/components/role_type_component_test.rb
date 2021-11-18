require "test_helper"

class RoleTypeComponentTest < ViewComponent::TestCase
  setup do
    @developer = developers(:available)
    @developer.part_time_contract = false
    @developer.full_time_contract = false
    @developer.full_time_employment = false
  end

  test "doesn't render with no role types selected" do
    developer = developers(:available)
    developer.part_time_contract = false
    developer.full_time_contract = false
    developer.full_time_employment = false

    render_inline RoleTypeComponent.new(developer)

    assert_no_select "*"
  end

  test "renders each selected role type" do
    developer = developers(:available)
    developer.part_time_contract = true
    developer.full_time_contract = true
    developer.full_time_employment = false

    render_inline RoleTypeComponent.new(developer)

    assert_text Developer.human_attribute_name("part_time_contract")
    assert_text Developer.human_attribute_name("full_time_contract")
  end
end
