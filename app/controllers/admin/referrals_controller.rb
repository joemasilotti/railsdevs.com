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

    def new
      @referral = Referral.new
      render :form
    end

    def create
      @referral = Referral.new(referral_params)

      if @referral.save
        redirect_to admin_referrals_path, notice: t(".created")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @referral = Referral.find(params[:id])
      render :form
    end

    def update
      @referral = Referral.find(params[:id])

      if @referral.update(referral_params)
        redirect_to admin_referrals_path, notice: t(".updated")
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end
end
