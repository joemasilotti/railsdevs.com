require "test_helper"

class RolesTest < ActionDispatch::IntegrationTest
  test "renders both options for new roles" do
    get new_role_path

    assert_select "h3", "I'm looking for work"
    assert_select "h3", "I'm hiring developers"
  end

  test "all svg elements have aria-hidden=true" do
    get new_role_path

    svg_count = css_select("main svg").count

    assert_select "main" do
      assert_select "svg:match('aria-hidden', ?)", "true", svg_count
    end
  end
end
