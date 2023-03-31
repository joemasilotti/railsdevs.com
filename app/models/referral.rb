class Referral < ApplicationRecord
  belongs_to :referred_user, class_name: "User"
  belongs_to :referring_user, class_name: "User", optional: true, counter_cache: true

  before_create :associate_referring_user

  validates :code, presence: true

  private

  def associate_referring_user
    referring_user = User.find_by(referral_code: code)
    self.referring_user = referring_user unless referring_user.nil?
  end
end
