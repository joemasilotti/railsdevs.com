require "test_helper"

module Admin
  class ReferralsTest < ActionDispatch::IntegrationTest
    test "must be an admin" do
      sign_in users(:empty)
      get admin_referrals_path
      assert_redirected_to root_path
    end

    test "list all users referrals" do
      user = users(:admin)
      create_referral_for(user)
      assert_equal 1, user.reload.referrals_count

      sign_in user
      get admin_referrals_path
      assert_select "td", text: "1"
    end

    private

    def create_referral_for(referring_user)
      Referral.create!(
        referring_user: referring_user,
        referred_user: users(:empty),
        code: referring_user.referral_code
      )
    end
  end
end
