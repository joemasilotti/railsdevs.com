require "test_helper"

module Developers
  class NewFieldsComponentTest < ViewComponent::TestCase
    test "renders if the user's developer profile is missing fields" do
      developers(:one).update!(scheduling_link: nil)
      render_inline NewFieldsComponent.new(users(:developer))
      assert_text I18n.t("developers.new_fields_component.title")
    end

    test "doesn't render if the developer profile is filled in" do
      render_inline NewFieldsComponent.new(users(:developer))
      refute_component_rendered
    end

    test "doesn't render if the user doesn't have a developer profile" do
      render_inline NewFieldsComponent.new(users(:empty))
      refute_component_rendered
    end

    test "doesn't render if the developer hasn't been saved yet" do
      user = users(:empty)
      user.build_developer
      render_inline NewFieldsComponent.new(user)
      refute_component_rendered
    end

    test "doesn't render if the user isn't signed in" do
      render_inline NewFieldsComponent.new(nil)
      refute_component_rendered
    end
  end
end
