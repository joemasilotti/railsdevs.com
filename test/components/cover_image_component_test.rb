require "test_helper"

class CoverImageComponentTest < ViewComponent::TestCase
  test "should render user cover_images" do
    @developer = developers(:available)
    @blob = active_storage_blobs(:two)
    render_inline(CoverImageComponent.new(developer: @developer))

    assert_selector("img[src$='#{@blob.filename}']")
  end

  test "should fall back to default" do
    @developer = developers(:unavailable)
    render_inline(CoverImageComponent.new(developer: @developer))

    assert_tag_source(filename: CoverImageComponent::DEFAULT_COVER)
  end

  test "should assign data atrributes" do
    @developer = developers(:available)
    render_inline(CoverImageComponent.new(developer: @developer, data: {controller: "test", action: "test->click#action"}))

    assert_selector("img[data-controller='test'][data-action='test->click#action']")
  end

  test "should assign classes" do
    @developer = developers(:available)
    render_inline(CoverImageComponent.new(developer: @developer, classes: "bg-red-100"))

    assert_selector("img[class~='bg-red-100']")
  end
end
