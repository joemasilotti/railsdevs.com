module Referrable
  extend ActiveSupport::Concern

  included do
    has_one :referral, dependent: :destroy, foreign_key: "referred_user_id"
    has_one :referring_user, through: :referral
    alias_method :referred_by, :referring_user

    has_many :referrals, foreign_key: "referring_user_id", dependent: :destroy
    has_many :referred_users, through: :referrals

    validates :referral_code, uniqueness: true, allow_nil: true
  end
end
