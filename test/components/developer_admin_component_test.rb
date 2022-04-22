require "test_helper"

class DeveloperAdminComponentTest < ViewComponent::TestCase
  test "renders for admins" do
    developer = developers(:one)

    render_inline DeveloperAdminComponent.new(developer, user: users(:admin))
    assert_selector "button"

    render_inline DeveloperAdminComponent.new(developer, user: developer.user)
    assert_no_selector "*"

    render_inline DeveloperAdminComponent.new(developer, user: nil)
    assert_no_selector "*"
  end
end
