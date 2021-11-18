require "test_helper"

class OpenGraphTagsComponentTest < ViewComponent::TestCase
  test "present attributes" do
    render_inline OpenGraphTagsComponent.new

    assert_meta property: "og:type"
    assert_meta property: "og:title", content: "railsdevs"
    assert_meta property: "og:description", content_begin_with: "Find Ruby"
    assert_meta property: "og:url"
    assert_meta property: "twitter:card"
  end

  test "overridden attributes" do
    render_inline OpenGraphTagsComponent.new(
      title: "Custom title",
      description: "And a custom description."
    )

    assert_meta property: "og:title", content: "Custom title"
    assert_meta property: "og:description", content: "And a custom description."
  end
end
