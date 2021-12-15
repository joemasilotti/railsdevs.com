require "test_helper"

class UserMenu::SignedInComponentTest < ViewComponent::TestCase
  include ActionDispatch::Routing::UrlFor
  include Rails.application.routes.url_helpers

  test "links to business if persisted" do
    user = users(:with_business)

    render_inline UserMenu::SignedInComponent.new(user)

    assert_link_to new_business_path
    assert_no_link_to new_developer_path
    assert_no_link_to new_role_path
  end

  test "links to developer if persisted" do
    user = users(:with_available_profile)

    render_inline UserMenu::SignedInComponent.new(user)

    assert_link_to new_developer_path
    assert_no_link_to new_business_path
    assert_no_link_to new_role_path
  end

  test "links to role if neither are persisted" do
    user = users(:empty)

    render_inline UserMenu::SignedInComponent.new(user)

    assert_link_to new_role_path
    assert_no_link_to new_developer_path
    assert_no_link_to new_business_path
  end

  test "links to conversations if user has any" do
    user = users(:with_developer_conversation)
    render_inline UserMenu::SignedInComponent.new(user)
    assert_link_to conversations_path

    user = users(:with_available_profile)
    render_inline UserMenu::SignedInComponent.new(user)
    assert_no_link_to conversations_path
  end

  test "links to conversations if user has a business profile" do
    user = users(:with_business)
    render_inline UserMenu::SignedInComponent.new(user)
    assert_link_to conversations_path
  end

  test "links to blocked conversations if user is an admin" do
    user = users(:admin)
    render_inline UserMenu::SignedInComponent.new(user)
    assert_link_to admin_conversations_path

    user = users(:with_business)
    render_inline UserMenu::SignedInComponent.new(user)
    assert_no_link_to admin_conversations_path
  end

  def assert_link_to(path)
    assert_selector "a[href='#{path}']"
  end

  def assert_no_link_to(path)
    assert_no_selector "a[href='#{path}']"
  end
end
