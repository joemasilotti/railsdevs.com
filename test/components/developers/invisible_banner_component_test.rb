require "test_helper"

module Developers
  class InvisibleBannerComponentTest < ViewComponent::TestCase
    test "renders if the user's developer profile is invisible" do
      developers(:one).update!(search_status: "invisible")
      render_inline InvisibleBannerComponent.new(users(:developer))
      assert_text I18n.t("developers.invisible_banner_component.title")
    end

    test "doesn't render if the developer profile is not invisible" do
      render_inline InvisibleBannerComponent.new(users(:developer))
      refute_component_rendered
    end

    test "doesn't render if the user doesn't have a developer profile" do
      render_inline InvisibleBannerComponent.new(users(:empty))
      refute_component_rendered
    end

    test "doesn't render if the developer hasn't been saved yet" do
      user = users(:empty)
      user.build_developer
      render_inline InvisibleBannerComponent.new(user)
      refute_component_rendered
    end

    test "doesn't render if the user isn't signed in" do
      render_inline InvisibleBannerComponent.new(nil)
      refute_component_rendered
    end

    test "doesn't render if the user is invisible but hasn't been saved yet" do
      user = users(:empty)
      user.build_developer(search_status: "invisible")
      render_inline InvisibleBannerComponent.new(user)
      refute_component_rendered
    end
  end
end
