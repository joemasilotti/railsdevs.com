require "test_helper"

class DeveloperOpenGraphTagsComponentTest < ViewComponent::TestCase
  include TurboNativeHelper

  test "present attributes" do
    developer = developers(:one)
    render_inline DeveloperOpenGraphTagsComponent.new(developer:)
    assert_selector "title", text: developer.hero, visible: false

    turbo_native_request!
    render_inline DeveloperOpenGraphTagsComponent.new(developer:)
    title = I18n.t("developer_open_graph_tags_component.turbo_native_title")
    assert_selector "title", exact_text: title, visible: false
  end
end
