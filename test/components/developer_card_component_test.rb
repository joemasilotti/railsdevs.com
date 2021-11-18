require "test_helper"

class DeveloperCardComponentTest < ViewComponent::TestCase
  setup do
    @developer = developers(:available)
  end

  test "should render hero" do
    render_inline(DeveloperCardComponent.new(developer: @developer))

    assert_selector("h2", text: @developer.hero)
  end

  test "should render bio" do
    render_inline(DeveloperCardComponent.new(developer: @developer))

    assert_selector("p", text: @developer.bio)
  end

  test "should render avatar" do
    @blob = active_storage_blobs(:one)
    render_inline(DeveloperCardComponent.new(developer: @developer))

    assert_selector("img[src$='#{@blob.filename}']")
  end

  test "should render availability" do
    render_inline(DeveloperCardComponent.new(developer: @developer))

    assert_selector("span", text: "Available now")
  end
end
