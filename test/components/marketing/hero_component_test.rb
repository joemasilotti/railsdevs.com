# frozen_string_literal: true

require "test_helper"

class Marketing::HeroComponentTest < ViewComponent::TestCase
  test "renders title with subtitle content" do
    render_inline Marketing::HeroComponent.new(
      title: "Test title", subtitle_1: "Blah foo", subtitle_2: "Blah bar"
    )

    assert_selector "h2", text: "Test title"
    assert_selector "span", text: "Blah foo"
    assert_selector "span", text: "Blah bar"
  end
end
