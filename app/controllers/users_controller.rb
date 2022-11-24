class UsersController < Devise::RegistrationsController
  include Referrals

  invisible_captcha only: :create

  def create
    super do |user|
      create_referral(user) if user.valid?
    end
  end
end
