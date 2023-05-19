require "test_helper"

module Developers
  class NewFieldComponentTest < ViewComponent::TestCase
    test "doesn't render if creating a new developer" do
      render_inline NewFieldComponent.new(Developer.new, :foo)
      refute_component_rendered
    end

    test "renders if the field is missing" do
      developer = developers(:one)
      developer.build_role_type
      render_inline NewFieldComponent.new(developer, :role_type)
      assert_text I18n.t("developers.new_field_component.new")
    end

    test "renders if the field is blank" do
      render_inline NewFieldComponent.new(developers(:prospect), :scheduling_link)
      assert_text I18n.t("developers.new_field_component.new")
    end

    test "defaults to large, anything else renders small" do
      assert NewFieldComponent.new(nil, nil).large?
      refute NewFieldComponent.new(nil, nil, size: :small).large?
    end
  end
end
