# frozen_string_literal: true

class Offer < ApplicationRecord
  include Offers::Notifications
  has_noticed_notifications

  belongs_to :conversation, touch: true
  has_one :developer, through: :conversation
  has_one :business, through: :conversation

  enum pay_rate_time_units: {hour: 0, day: 1, year: 2}
  enum state: {proposed: 0, accepted: 1, declined: 2}

  validates :conversation, uniqueness: {conditions: -> { active }, unless: :declined?}
  validates :start_date, presence: true
  validates :pay_rate_value, presence: true
  validates :pay_rate_time_unit, presence: true

  scope :active, -> { where(state: %i[accepted proposed]) }

  alias_attribute :sender, :business
  alias_attribute :receiver, :developer

  def deleted_sender?
    business.nil?
  end

  def pay_rate_time_unit_key
    self.class.pay_rate_time_units.key(pay_rate_time_unit)
  end
end
