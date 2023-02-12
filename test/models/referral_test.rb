require "test_helper"

class ReferralTest < ActiveSupport::TestCase
  setup do
    @referring_user = users(:developer)
    @referring_user.update!(referral_code: code)

    @referred_user = users(:empty)
  end

  test "associates the referrer to the referral" do
    referral = Referral.create!(referred_user: @referred_user, code: code)
    assert_equal @referring_user, referral.reload.referring_user
  end

  test "creates referral even when referrer cannot be found" do
    referral = Referral.create!(referred_user: @referred_user, code: "BOGUS")
    assert_nil referral.reload.referring_user
  end

  def code
    "ABDDEF"
  end
end
