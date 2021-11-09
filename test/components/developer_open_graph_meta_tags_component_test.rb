require "test_helper"

class DeveloperOpenGraphTagsComponentTest < ViewComponent::TestCase
  test "always includes basic tags" do
    developer = Developer.new(id: 123, hero: "hero text", bio: "bio text")

    render_inline(DeveloperOpenGraphTagsComponent.new(developer: developer))

    assert_meta property: "og:title", content: "hero text"
    assert_meta property: "og:description", content: "bio text"
    assert_meta property: "og:url", content: "http://test.host/developers/123"
  end

  test "excludes special tags when not present" do
    developer = Developer.new(id: 123)

    render_inline(DeveloperOpenGraphTagsComponent.new(developer: developer))

    assert_meta property: "og:image", count: 0
    assert_meta property: "twitter:site", count: 0
  end

  test "includes image when present" do
    developer = Developer.new(id: 123)
    developer.build_avatar_blob(filename: "avatar.jpg")

    render_inline(DeveloperOpenGraphTagsComponent.new(developer: developer))

    assert_meta property: "og:image", content_end_with: "/avatar.jpg"
  end

  test "includes twitter when present" do
    developer = Developer.new(id: 123, twitter: "me")

    render_inline(DeveloperOpenGraphTagsComponent.new(developer: developer))

    assert_meta property: "twitter:site", content: "@me"
  end

  def assert_meta(property:, content: nil, content_end_with: nil, count: 1)
    selector = "meta[property='#{property}']"
    selector += "[content='#{content}']" if content.present?
    selector += "[content$='#{content}']" if content_end_with.present?

    assert_selector selector, visible: false, count: count
  end
end
