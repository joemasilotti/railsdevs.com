require "test_helper"

class RenderableComponentTest < ViewComponent::TestCase
  test "renders when content is given" do
    render_inline RenderableComponent.new do
      "<h1>Hi</h1>".html_safe
    end
    assert_selector "div > h1"
    assert_text "Hi"
  end

  test "doesn't render when no content is given" do
    render_inline RenderableComponent.new
    refute_component_rendered
  end

  test "renders the given CSS classes" do
    render_inline RenderableComponent.new("wrapper") do
      "<h1>Hi</h1>".html_safe
    end
    assert_selector "div.wrapper > h1"
  end
end
