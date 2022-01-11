require "test_helper"

class SidekiqPolicyTest < ActiveSupport::TestCase
  test "only admins can see the route" do
    assert SidekiqPolicy.new(users(:admin)).visible?
    refute SidekiqPolicy.new(users(:empty)).visible?
  end

  test "everyone can see the route in development" do
    environment = ActiveSupport::EnvironmentInquirer.new("development")
    assert SidekiqPolicy.new(users(:admin), environment:).visible?
    assert SidekiqPolicy.new(users(:empty), environment:).visible?
  end
end
