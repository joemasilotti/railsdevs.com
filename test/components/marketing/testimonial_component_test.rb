require "test_helper"

class Marketing::TestimonialComponentTest < ViewComponent::TestCase
  test "renders title with text content" do
    render_inline Marketing::TestimonialComponent.new(
      title: "Test title", name: "Blah McBlah", testimonial: "I love blah blah"
    )

    assert_selector "p", text: "I love blah blah"
    assert_selector "dt", text: "Blah McBlah"
    assert_selector "dd", text: "Test title"
  end
end
