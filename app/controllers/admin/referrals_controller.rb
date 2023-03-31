module Admin
  class ReferralsController < ApplicationController
    include Pagy::Backend

    def index
      @users = User.where.not(referral_code: nil)
      @pagy, @users = pagy(@users)
    end
  end
end
