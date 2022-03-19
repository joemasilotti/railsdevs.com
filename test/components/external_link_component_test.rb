require "test_helper"

class ExternalLinkComponentTest < ViewComponent::TestCase
  test "adds https:// if no scheme given" do
    component = ExternalLinkComponent.new("google.com")
    render_inline(component)
    assert_selector "a[href='https://google.com']"
  end

  test "keeps scheme if http or https" do
    component = ExternalLinkComponent.new("http://google.com")
    render_inline(component)
    assert_selector "a[href='http://google.com']"

    component = ExternalLinkComponent.new("https://google.com")
    render_inline(component)
    assert_selector "a[href='https://google.com']"
  end

  test "renders nothing with a blank href" do
    component = ExternalLinkComponent.new("")
    render_inline(component)
    refute_component_rendered
  end

  test "opens the link in a new tab/window" do
    component = ExternalLinkComponent.new("google.com")
    render_inline(component)
    assert_selector "a[href='https://google.com'][target='_blank']"
  end
end
