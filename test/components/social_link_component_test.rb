require "test_helper"

class SocialLinkComponentTest < ViewComponent::TestCase
  test "doesn't render if no handle" do
    render_inline SocialLinkComponent.new(nil, :github)
    refute_component_rendered
  end

  test "github" do
    render_inline SocialLinkComponent.new("gh", :github)
    assert_selector "a[href='https://github.com/gh']"
    assert_selector "svg[title='GitHub logo']"
    assert_text "gh"
  end

  test "twitter" do
    render_inline SocialLinkComponent.new("tw", :twitter)
    assert_selector "a[href='https://twitter.com/tw']"
    assert_selector "svg[title='Twitter logo']"
    assert_text "tw"
  end

  test "linkedin" do
    render_inline SocialLinkComponent.new("li", :linkedin)
    assert_selector "a[href='https://www.linkedin.com/in/li']"
    assert_selector "svg[title='LinkedIn logo']"
    assert_text "li"
  end

  test "sanitizes the handle" do
    render_inline SocialLinkComponent.new("<script>gh</script>", :github)
    assert_selector "a[href='https://github.com/gh']"
  end
end
