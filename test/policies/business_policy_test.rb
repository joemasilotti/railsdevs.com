require "test_helper"

class BusinessPolicyTest < ActiveSupport::TestCase
  test "can update their own business profile" do
    user = users(:business)
    assert BusinessPolicy.new(user.business, user:).update?
  end

  test "cannot update another's business profile" do
    user = users(:empty)
    business = businesses(:one)
    refute BusinessPolicy.new(business, user:).update?
  end

  test "developer notifications are permitted for active business subscriptions" do
    user = users(:business)
    assert_permitted_params(user, {
      "contact_name" => "Joe"
    })

    user = users(:subscribed_business)
    assert_permitted_params(user, {
      "contact_name" => "Joe",
      "developer_notifications" => :daily
    })
  end

  def assert_permitted_params(user, expected_permitted_params)
    policy = BusinessPolicy.new(user.business, user:)
    permitted = policy.apply_scope(params, type: :action_controller_params).to_h
    assert_equal(expected_permitted_params, permitted)
  end

  def params
    ActionController::Parameters.new({
      contact_name: "Joe",
      developer_notifications: :daily
    })
  end
end
