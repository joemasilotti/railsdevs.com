require "test_helper"

class AvatarComponentTest < ViewComponent::TestCase
  include ActionView::Helpers::AssetUrlHelper

  test "should allow user avatars" do
    @developer = developers(:available)
    @blob = active_storage_blobs(:one)
    render_inline(AvatarComponent.new(developer: @developer))

    assert_selector("img[src$='#{@blob.filename}']")
  end

  test "should fall back to default" do
    @developer = developers(:unavailable)
    render_inline(AvatarComponent.new(developer: @developer))

    assert_selector("img[src*='avatar']")
  end
end
