require "test_helper"

class OpenGraphTagsComponentTest < ViewComponent::TestCase
  test "present attributes" do
    render_inline OpenGraphTagsComponent.new

    assert_meta property: "og:type"
    assert_meta property: "og:title"
    assert_meta property: "og:description"
    assert_meta property: "og:url"
    assert_meta property: "twitter:card"
  end
end
