require "test_helper"

class ExternalLinkComponentTest < ViewComponent::TestCase
  test "adds https:// if no scheme given" do
    component = ExternalLinkComponent.new("Google", "google.com")
    render_inline(component)
    assert_selector "a[href='https://google.com']"
  end

  test "keeps scheme if http or https" do
    component = ExternalLinkComponent.new("Google", "http://google.com")
    render_inline(component)
    assert_selector "a[href='http://google.com']"

    component = ExternalLinkComponent.new("Google", "https://google.com")
    render_inline(component)
    assert_selector "a[href='https://google.com']"
  end

  test "renders nothing with a blank href" do
    component = ExternalLinkComponent.new("Blank", "")
    render_inline(component)
    assert_no_select "*"
  end

  test "merges given options with target='_blank'" do
    component = ExternalLinkComponent.new("Google", "google.com", {
      class: "text-gray-900"
    })
    render_inline(component)
    assert_selector "a.text-gray-900[href='https://google.com'][target='_blank']"
  end
end
