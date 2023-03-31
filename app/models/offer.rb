class Offer < ApplicationRecord
  belongs_to :conversation, touch: true
  has_one :developer, through: :conversation
  has_one :business, through: :conversation

  enum pay_rate_time_units: { hour: 0, day: 1, year: 2 }
end
