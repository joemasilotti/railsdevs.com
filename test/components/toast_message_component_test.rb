require "test_helper"

class ToastMessageComponentTest < ViewComponent::TestCase
  include ActionView::Helpers::TagHelper

  test "basic toast message with icon" do
    render_inline(ToastMessageComponent.new(icon: "information_circle")) do |c|
      c.message { "Operation successful" }
    end

    expect_to_be_color(color: :blue)
    assert_no_selector("h3")
    assert_selector("svg")
    assert_selector("div", text: "Operation successful")
  end

  test "error state toast message - color red" do
    render_inline(ToastMessageComponent.new(icon: "information_circle", color: :red)) do |c|
      c.message { "Operation successful" }
    end

    expect_to_be_color(color: :red)
  end

  test "toast message can show a title" do
    render_inline(ToastMessageComponent.new(icon: "x_circle", color: :red)) do |c|
      c.title { "There was 1 error" }
      c.message { "Missing parameter" }
    end

    expect_to_be_color(color: :red)
    assert_selector("h3", text: "There was 1 error")
    assert_selector("div", text: "Missing parameter")
  end

  test "toast messages can have multiple messages" do
    render_inline(ToastMessageComponent.new(icon: "x_circle", color: :red)) do |c|
      c.title { "There were 2 errors" }
      c.message { tag.p("Missing name") }
      c.message { tag.p("Missing email") }
    end

    expect_to_be_color(color: :red)
    assert_selector("h3", text: "There were 2 errors")
    assert_selector("p", text: "Missing name")
    assert_selector("p", text: "Missing email")
  end

  test "toast messages can have multiple messages and ask for a different messages container" do
    render_inline(ToastMessageComponent.new(icon: "x_circle", color: :red, messages_tag: :ul)) do |c|
      c.title { "There were 3 errors" }
      c.message { tag.li("Missing name") }
      c.message { tag.li("Missing email") }
      c.message { tag.li("Missing photo") }
    end

    expect_to_be_color(color: :red)
    assert_selector("h3", text: "There were 3 errors")
    assert_selector("ul")
    assert_selector("li", text: "Missing name")
    assert_selector("li", text: "Missing email")
    assert_selector("li", text: "Missing photo")
  end

  def expect_to_be_color(color:)
    assert_selector(".bg-#{color}-50")
    assert_selector(".text-#{color}-400")
    assert_selector(".text-#{color}-700")
  end
end
