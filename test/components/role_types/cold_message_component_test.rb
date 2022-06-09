require "test_helper"

module RoleTypes
  class ColdMessageComponentTest < ViewComponent::TestCase
    test "doesn't render if no role types are enabled" do
      role_type = role_types(:none)
      render_inline ColdMessageComponent.new(role_type)
      assert_no_selector "*"
    end

    test "enabled role types have a checkbox and are green" do
      role_type = role_types(:some)
      render_inline ColdMessageComponent.new(role_type)
      assert_selector "li.text-green-700 svg[title='Check Circle']" do
        assert_text "Part-time contract"
      end
    end

    test "disabled role types have an x and are gray" do
      role_type = role_types(:some)
      render_inline ColdMessageComponent.new(role_type)
      assert_selector "li:not(.text-green-700) svg[title='X Circle']" do
        assert_text "Full-time employment"
      end
    end
  end
end
