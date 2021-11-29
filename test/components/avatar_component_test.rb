require "test_helper"

class AvatarComponentTest < ViewComponent::TestCase
  include ActionView::Helpers::AssetUrlHelper

  test "should render user avatars" do
    @developer = developers(:available)
    @blob = active_storage_blobs(:one)
    render_inline(AvatarComponent.new(avatarable: @developer))

    assert_selector("img[src$='#{@blob.filename}']")
  end

  test "should fall back to default" do
    @developer = developers(:unavailable)
    render_inline(AvatarComponent.new(avatarable: @developer))

    assert_tag_source(filename: AvatarComponent::DEFAULT_AVATAR)
  end

  test "should assign data attributes" do
    @developer = developers(:available)
    render_inline(AvatarComponent.new(avatarable: @developer, data: {controller: "test", action: "test->click#action"}))

    assert_selector("img[data-controller='test'][data-action='test->click#action']")
  end
end
