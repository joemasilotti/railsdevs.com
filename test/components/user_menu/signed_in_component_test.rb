require "test_helper"

class UserMenu::SignedInComponentTest < ViewComponent::TestCase
  include ActionDispatch::Routing::UrlFor
  include Rails.application.routes.url_helpers

  test "links to business if persisted" do
    user = users(:business)

    render_inline UserMenu::SignedInComponent.new(user)

    assert_link_to new_business_path
    refute_link_to new_developer_path
    refute_link_to new_role_path
  end

  test "links to developer if persisted" do
    user = users(:developer)

    render_inline UserMenu::SignedInComponent.new(user)

    assert_link_to developer_path(user.developer)
    refute_link_to new_business_path
    refute_link_to new_role_path
  end

  test "links to role if neither are persisted" do
    user = users(:empty)

    render_inline UserMenu::SignedInComponent.new(user)

    assert_link_to new_role_path
    refute_link_to new_developer_path
    refute_link_to new_business_path
  end

  test "links to conversations if user has any" do
    user = users(:prospect_developer)
    render_inline UserMenu::SignedInComponent.new(user)
    assert_link_to conversations_path

    user = users(:developer)
    render_inline UserMenu::SignedInComponent.new(user)
    refute_link_to conversations_path
  end

  test "links to conversations if user has a business profile" do
    user = users(:business)
    render_inline UserMenu::SignedInComponent.new(user)
    assert_link_to conversations_path
  end

  test "links to blocked conversations if user is an admin" do
    user = users(:admin)
    render_inline UserMenu::SignedInComponent.new(user)
    assert_link_to admin_conversations_path

    user = users(:business)
    render_inline UserMenu::SignedInComponent.new(user)
    refute_link_to admin_conversations_path
  end

  test "links to Stripe Customer Portal if the user is a customer" do
    user = users(:subscribed_business)
    render_inline UserMenu::SignedInComponent.new(user)
    assert_link_to stripe_portal_path

    user = users(:empty)
    render_inline UserMenu::SignedInComponent.new(user)
    refute_link_to stripe_portal_path
  end

  test "links to new notifications view when no new notifications exist" do
    user = users(:business)

    render_inline UserMenu::SignedInComponent.new(user)
    assert_link_to notifications_path
  end

  test "links to new notifications view when new notifications exist" do
    user = users(:business)
    developer = developers(:one)
    Message.create!(developer:, business: user.business, sender: developer, body: "Hello!")

    render_inline UserMenu::SignedInComponent.new(user)
    assert_link_to notifications_path
  end

  test "shows red alert dot when new notifications exist" do
    user = users(:business)
    developer = developers(:one)
    Message.create!(developer:, business: user.business, sender: developer, body: "Hello!")

    render_inline UserMenu::SignedInComponent.new(user)
    assert_css "bg-red-400"
  end

  test "does not show red alert dot when no new notifications exist" do
    user = users(:business)

    render_inline UserMenu::SignedInComponent.new(user)
    assert_no_css "bg-red-400"
  end

  def assert_css(class_name)
    assert_selector ".#{class_name}"
  end

  def assert_no_css(class_name)
    assert_no_selector ".#{class_name}"
  end

  def assert_element(id)
    assert_selector "##{id}"
  end

  def assert_no_element(id)
    assert_no_selector "##{id}"
  end

  def assert_link_to(path)
    assert_selector "a[href='#{path}']"
  end

  def refute_link_to(path)
    assert_no_selector "a[href='#{path}']"
  end
end
