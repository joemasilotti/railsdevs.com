require "test_helper"

class UserTest < ActiveSupport::TestCase
  include SubscriptionsHelper

  test "conversations where the user is the developer" do
    user = users(:prospect_developer)
    assert_equal user.conversations, [conversations(:one)]
  end

  test "conversations where the user is the business" do
    user = users(:subscribed_business)
    assert_equal user.conversations, [conversations(:one)]
  end

  test "blocked conversations are ignored" do
    user = users(:subscribed_business)
    assert user.conversations.include?(conversations(:one))

    conversations(:one).touch(:developer_blocked_at)
    refute user.conversations.include?(conversations(:one))
  end

  test "customer name for Pay" do
    user = users(:business)
    assert_equal user.pay_customer_name, businesses(:one).name

    user = users(:empty)
    assert_nil user.pay_customer_name
  end

  test "search" do
    assert_includes User.search("ADMIN@"), users(:admin)
    assert_includes User.search("one"), users(:developer)
    assert_includes User.search("owner"), users(:business)
    assert_includes User.search("company"), users(:business)
  end

  test "needs to sign the hiring agreement when active, not on a legacy plan, and not yet signed" do
    user = users(:subscribed_business)

    # Already signed.
    refute user.needs_to_sign_hiring_agreement?

    # Not signed.
    hiring_agreements_signatures(:one).destroy
    assert user.needs_to_sign_hiring_agreement?

    # Not signed but not active.
    HiringAgreements::Term.sole.deactivate!
    refute user.needs_to_sign_hiring_agreement?

    # Active and not signed but on legacy plan.
    HiringAgreements::Term.sole.activate!
    update_subscription(:legacy)
    refute user.needs_to_sign_hiring_agreement?
  end

  test "business name, then developer name, then email" do
    user = User.new(email: "user@example.com")
    assert_equal "user@example.com", user.name

    user.developer = Developer.new(name: "Developer Name")
    assert_equal "Developer Name", user.name

    user.business = Business.new(name: "Business Name")
    assert_equal "Business Name", user.name
  end
end
