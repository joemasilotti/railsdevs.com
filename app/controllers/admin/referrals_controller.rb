module Admin
  class ReferralsController < ApplicationController
    include Pagy::Backend

    def index
      @users = User.where.not(referral_code: nil)
      @pagy, @users = pagy(@users)
    end

    def show
      @user = User.find(params[:id])
      @entity = @user.developer || @user.company
      @referrals = @user.referrals
      @pagy, @referrals = pagy(@referrals)
    end
  end
end
