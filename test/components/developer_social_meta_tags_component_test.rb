require "test_helper"

class DeveloperSocialMetaTagsComponentTest < ViewComponent::TestCase
  def test_always_includes_basic_tags
    developer = Developer.new(
      id: 123,
      hero: "hero text",
      bio: "bio text"
    )
    render_inline(DeveloperSocialMetaTagsComponent.new(developer: developer))

    assert_meta "[property='og:title'][content='hero text']"
    assert_meta "[property='og:description'][content='bio text']"
    assert_meta "[property='og:url'][content='http://test.host/developers/123']"
  end

  def test_excludes_special_tags_when_not_present
    developer = Developer.new(id: 123)
    render_inline(DeveloperSocialMetaTagsComponent.new(developer: developer))

    assert_meta "[property='og:image']", count: 0
    assert_meta "[name='twitter:site']", count: 0
  end

  def test_includes_image_when_present
    developer = Developer.new(id: 123)
    developer.build_avatar_blob(filename: "avatar.jpg")
    render_inline(DeveloperSocialMetaTagsComponent.new(developer: developer))

    assert_meta "[property='og:image'][content$='/avatar.jpg']"
  end

  def test_includes_twitter_when_present
    developer = Developer.new(id: 123, twitter: "me")
    render_inline(DeveloperSocialMetaTagsComponent.new(developer: developer))

    assert_meta "[name='twitter:site'][content='@me']"
  end

  def assert_meta(attributes_selector, count: 1)
    assert_selector "meta#{attributes_selector}", visible: false, count: count
  end
end
