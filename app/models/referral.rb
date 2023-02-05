class Referral < ApplicationRecord
  belongs_to :user
  belongs_to :referrer, class_name: "User", optional: true
  before_create :associate_referrer

  validates :code, presence: true

  private

  def associate_referrer
    referring_user = User.find_by(referral_code: code)
    self.referrer = referring_user unless referring_user.nil?
  end
end
