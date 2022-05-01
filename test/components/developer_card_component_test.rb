require "test_helper"

class DeveloperCardComponentTest < ViewComponent::TestCase
  setup do
    @developer = developers(:one)
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
    @blob = active_storage_blobs(:lovelace)
    render_inline(DeveloperCardComponent.new(developer: @developer))

    assert_selector("img[src$='#{@blob.filename}']")
  end

  test "should render availability" do
    render_inline(DeveloperCardComponent.new(developer: @developer))

    assert_selector("span", text: "Available now")
  end

  test "renders the accent border and badge if featured" do
    render_inline(DeveloperCardComponent.new(developer: @developer, featured: true))
    assert_selector "a.border-l-4.border-blue-400"
    assert_text I18n.t("developer_card_component.featured")

    render_inline(DeveloperCardComponent.new(developer: @developer))
    assert_no_selector "a.border-l-4.border-blue-400"
    assert_no_text I18n.t("developer_card_component.featured")
  end
end
