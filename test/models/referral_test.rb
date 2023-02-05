require "test_helper"

class ReferralTest < ActiveSupport::TestCase
  setup do
    @referrer = users(:referrer)
    @user = users(:empty)
  end

  test "associates the referrer to the referral" do
    user.create_referral! code: referrer.referral_code
    assert_equal referrer, user.referral.referrer
  end

  test "creates referral when referrer cannot be found" do
    user.create_referral! code: "newcode123"
    assert_nil user.referral.referrer
  end

  private

  attr_reader :referrer, :user
end
