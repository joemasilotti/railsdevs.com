require "test_helper"

class NavBar::UserComponentTest < ViewComponent::TestCase
  include ActionDispatch::Routing::UrlFor
  include Rails.application.routes.url_helpers

  test "renders links" do
    render_inline NavBar::UserComponent.new(users(:empty), links: [
      Link.new("Developers", developers_path),
      Link.new("Pricing", pricing_path)
    ])

    assert_link_to developers_path
    assert_link_to pricing_path
  end

  test "links to business if persisted" do
    user = users(:business)

    render_inline NavBar::UserComponent.new(user, links: [])

    assert_link_to business_path(user.business)
    assert_no_link_to new_developer_path
    assert_no_link_to new_role_path
  end

  test "links to developer if persisted" do
    user = users(:developer)

    render_inline NavBar::UserComponent.new(user, links: [])

    assert_link_to developer_path(user.developer)
    assert_no_link_to new_business_path
    assert_no_link_to new_role_path
  end

  test "links to role if neither are persisted" do
    user = users(:empty)

    render_inline NavBar::UserComponent.new(user, links: [])

    assert_link_to new_role_path
    assert_no_link_to new_developer_path
    assert_no_link_to new_business_path
  end

  test "links to conversations if user has any" do
    user = users(:prospect_developer)
    render_inline NavBar::UserComponent.new(user, links: [])
    assert_link_to conversations_path

    user = users(:developer)
    render_inline NavBar::UserComponent.new(user, links: [])
    assert_no_link_to conversations_path
  end

  test "links to conversations if user has a business profile" do
    user = users(:business)
    render_inline NavBar::UserComponent.new(user, links: [])
    assert_link_to conversations_path
  end

  test "links to blocked conversations if user is an admin" do
    user = users(:admin)
    render_inline NavBar::UserComponent.new(user, links: [])
    assert_link_to admin_conversations_blocks_path

    user = users(:business)
    render_inline NavBar::UserComponent.new(user, links: [])
    assert_no_link_to admin_conversations_blocks_path
  end

  test "links to Stripe Customer Portal if the user is a customer" do
    user = users(:subscribed_business)
    render_inline NavBar::UserComponent.new(user, links: [])
    assert_link_to stripe_portal_path

    user = users(:empty)
    render_inline NavBar::UserComponent.new(user, links: [])
    assert_no_link_to stripe_portal_path
  end

  test "links to new notifications view when no new notifications exist" do
    user = users(:business)

    render_inline NavBar::UserComponent.new(user, links: [])
    assert_link_to notifications_path
  end

  test "links to new notifications view when new notifications exist" do
    user = users(:business)
    developer = developers(:one)
    Message.create!(developer:, business: user.business, sender: developer, body: "Hello!")

    render_inline NavBar::UserComponent.new(user, links: [])
    assert_link_to notifications_path
  end

  test "shows red alert dot when new notifications exist" do
    user = users(:subscribed_business)
    render_inline NavBar::UserComponent.new(user, links: [])
    assert_selector "a[href='/notifications']" do
      assert_selector ".bg-red-400"
    end
  end

  test "does not show red alert dot when no new notifications exist" do
    user = users(:business)

    render_inline NavBar::UserComponent.new(user, links: [])
    assert_no_selector ".bg-red-400"
  end

  def assert_link_to(path)
    assert_selector "a[href='#{path}']"
  end

  def assert_no_link_to(path)
    assert_no_selector "a[href='#{path}']"
  end
end
