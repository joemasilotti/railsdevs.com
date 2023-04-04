require "test_helper"

module Developers
  class BannerComponentTest < ViewComponent::TestCase
    test "renders new fields component title if none of the other banner renders" do
      developers(:one).update!(scheduling_link: nil)
      new_fields_component = NewFieldsComponent.new(users(:developer))
      invisible_banner_component = InvisibleBannerComponent.new(users(:developer))
      unseeded_warning_component = UnseededWarningComponent.new(seedable: true)
      render_inline BannerComponent.new([unseeded_warning_component, invisible_banner_component, new_fields_component])
      assert_text I18n.t("developers.new_fields_component.title")
    end

    test "renders invisible banner component's title if BOTH new fields component and invisible banner component can be rendered" do
      developers(:one).update!(scheduling_link: nil, search_status: "invisible")
      new_fields_component = NewFieldsComponent.new(users(:developer))
      invisible_banner_component = InvisibleBannerComponent.new(users(:developer))
      unseeded_warning_component = UnseededWarningComponent.new(seedable: true)
      render_inline BannerComponent.new([unseeded_warning_component, invisible_banner_component, new_fields_component])
      assert_text I18n.t("developers.invisible_banner_component.title")
    end

    test "doesn't render any banner if none of the banners can be rendered" do
      new_fields_component = NewFieldsComponent.new(users(:developer))
      invisible_banner_component = InvisibleBannerComponent.new(users(:developer))
      unseeded_warning_component = UnseededWarningComponent.new(seedable: true)
      render_inline BannerComponent.new([unseeded_warning_component, invisible_banner_component, new_fields_component])
      refute_component_rendered
    end

    test "renders unseeded data warning if it can be rendered" do
      Developer.destroy_all
      new_fields_component = NewFieldsComponent.new(nil)
      invisible_banner_component = InvisibleBannerComponent.new(nil)
      unseeded_warning_component = UnseededWarningComponent.new(seedable: true)
      render_inline BannerComponent.new([unseeded_warning_component, invisible_banner_component, new_fields_component])
      assert_text "Run bin/rails db:seed"
    end
  end
end
