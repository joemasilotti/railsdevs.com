require "test_helper"

class NewDeveloperFieldsComponentTest < ViewComponent::TestCase
  test "renders if the user's developer profile is missing fields" do
    render_inline NewDeveloperFieldsComponent.new(users(:with_unavailable_profile))
    assert_text I18n.t("new_developer_fields_component.title")
  end

  test "doesn't render if the developer profile is filled in" do
    render_inline NewDeveloperFieldsComponent.new(users(:with_complete_profile))
    assert_no_selector "*"
  end

  test "doesn't render if the user doesn't have a developer profile" do
    render_inline NewDeveloperFieldsComponent.new(users(:empty))
    assert_no_selector "*"
  end

  test "doesn't render if the developer hasn't been saved yet" do
    users(:empty).build_developer
    render_inline NewDeveloperFieldsComponent.new(users(:empty))
    assert_no_selector "*"
  end

  test "doesn't render if the user isn't signed in" do
    render_inline NewDeveloperFieldsComponent.new(nil)
    assert_no_selector "*"
  end

  test "doesn't render if disabled" do
    render_inline NewDeveloperFieldsComponent.new(users(:with_unavailable_profile), enabled: false)
    assert_no_selector "*"
  end
end
