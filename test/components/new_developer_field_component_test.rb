require "test_helper"

class NewDeveloperFieldComponentTest < ViewComponent::TestCase
  test "doesn't render if creating a new developer" do
    render_inline NewDeveloperFieldComponent.new(Developer.new, :foo)
    assert_no_selector "*"
  end

  test "renders if the field is missing" do
    render_inline NewDeveloperFieldComponent.new(developers(:unavailable), :role_type)
    assert_text I18n.t("new_developer_field_component.new")
  end

  test "renders if the field is blank" do
    render_inline NewDeveloperFieldComponent.new(developers(:with_conversation), :available_on)
    assert_text I18n.t("new_developer_field_component.new")
  end

  test "defaults to large, anything else renders small" do
    assert NewDeveloperFieldComponent.new(nil, nil).large?
    refute NewDeveloperFieldComponent.new(nil, nil, size: :small).large?
  end
end
