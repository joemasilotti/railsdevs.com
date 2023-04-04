module Admin
  module Users
    class ReferralsController < ApplicationController
      include Pagy::Backend

      def index
        @user = User.find(params[:user_id])
        @referrals = @user.referrals.includes(referred_user: [:developer, :business])
        @pagy, @referrals = pagy(@referrals)
      end
    end
  end
end
