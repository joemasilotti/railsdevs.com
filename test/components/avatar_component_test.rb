require "test_helper"

class AvatarComponentTest < ViewComponent::TestCase
  include ActionView::Helpers::AssetUrlHelper
  include ActionView::Helpers::UrlHelper
  include Rails.application.routes.url_helpers

  setup do
    @developer = developers(:one)
  end

  test "should render user avatars" do
    blob = active_storage_blobs(:lovelace)
    render_inline(AvatarComponent.new(avatarable: @developer))

    assert_selector("img[src$='#{blob.filename}']")
  end

  test "should render user avatar at specified variant" do
    avatar_component = AvatarComponent.new(avatarable: @developer, variant: :thumb)
    render_inline(avatar_component)

    assert_instance_of ActiveStorage::VariantWithRecord, avatar_component.image
    assert_equal [32, 32], avatar_component.image.variation.transformations[:resize_to_limit]
    assert_equal [64, 64], avatar_component.image_2x.variation.transformations[:resize_to_limit]
  end

  test "should render srcset for 2x images" do
    avatar_component = AvatarComponent.new(avatarable: @developer, variant: :thumb)
    render_inline(avatar_component)

    assert_selector("img[srcset$='#{url_for @developer.avatar.variant(:thumb_2x)} 2x']")
  end

  test "should fall back to default" do
    @developer.avatar.detach
    render_inline(AvatarComponent.new(avatarable: @developer))

    assert_tag_source(filename: AvatarComponent::DEFAULT_AVATAR)
  end

  test "should assign data attributes" do
    render_inline(AvatarComponent.new(avatarable: @developer, data: {controller: "test", action: "test->click#action"}))

    assert_selector("img[data-controller='test'][data-action='test->click#action']")
  end
end
