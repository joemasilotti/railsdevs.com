class Offer < ApplicationRecord
  belongs_to :conversation, touch: true
  has_one :developer, through: :conversation
  has_one :business, through: :conversation

  enum pay_rate_time_units: { hour: 0, day: 1, year: 2 }
  enum state: { proposed: 0, accepted: 1, declined: 2 }

  def sender
    business
  end

  def deleted_sender?
    business.nil?
  end

  def comment?
    comment.present?
  end

  def pay_rate_time_unit_key
    self.class.pay_rate_time_units.key(pay_rate_time_unit)
  end
end
