# frozen_string_literal: true

require "test_helper"

class TechStackComponentTest < ViewComponent::TestCase
  # def test_component_renders_something_useful
  # assert_equal(
  #   %(<span>Hello, components!</span>),
  #   render_inline(TechStackComponent.new(message: "Hello, components!")).css("span").to_html
  # )
  # end

  test "renders nothing with a blank body" do
    component = TechStackComponent.new("")
    render_inline(component)
    refute_component_rendered
  end
end
