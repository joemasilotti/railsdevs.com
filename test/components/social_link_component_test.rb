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

  test "gitlab" do
    render_inline SocialLinkComponent.new("gl", :gitlab)
    assert_selector "a[href='https://gitlab.com/gl']"
    assert_selector "svg[title='GitLab logo']"
    assert_text "gl"
  end

  test "twitter" do
    render_inline SocialLinkComponent.new("tw", :twitter)
    assert_selector "a[href='https://twitter.com/tw']"
    assert_selector "svg[title='Twitter logo']"
    assert_text "tw"
  end

  test "mastodon" do
    render_inline SocialLinkComponent.new("https://ma", :mastodon)
    assert_selector "a[href='https://ma']"
    assert_selector "svg[title='Mastodon logo']"
    assert_text "ma"
  end

  test "linkedin" do
    render_inline SocialLinkComponent.new("li", :linkedin)
    assert_selector "a[href='https://www.linkedin.com/in/li']"
    assert_selector "svg[title='LinkedIn logo']"
    assert_text "li"
  end

  test "stack overflow" do
    render_inline SocialLinkComponent.new("12345", :stack_overflow)
    assert_selector "a[href='https://stackoverflow.com/users/12345']"
    assert_selector "svg[title='Stack Overflow logo']"
    assert_text "12345"
  end

  test "sanitizes the handle" do
    render_inline SocialLinkComponent.new("<script>gh</script>", :github)
    assert_selector "a[href='https://github.com/gh']"
  end
end
