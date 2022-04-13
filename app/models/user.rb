class User < ApplicationRecord
  devise :confirmable,
    :database_authenticatable,
    :recoverable,
    :registerable,
    :rememberable,
    :validatable
  pay_customer

  has_many :notifications, as: :recipient, dependent: :destroy
  has_one :business, dependent: :destroy
  has_one :developer, dependent: :destroy

  has_many :conversations, ->(user) {
    unscope(where: :user_id)
      .left_joins(:business, :developer)
      .where("businesses.user_id = ? OR developers.user_id = ?", user.id, user.id)
      .visible
  }

  scope :admin, -> { where(admin: true) }

  def pay_customer_name
    business&.name
  end

  def active_business_subscription?
    subscriptions.active.any?
  end

  def active_legacy_business_subscription?
    legacy_plan = BusinessSubscription::Legacy.new
    subscriptions.where(processor_plan: legacy_plan.plan).active.any?
  end

  def active_part_time_business_subscription?
    part_time_plan = BusinessSubscription::PartTime.new
    subscriptions.where(processor_plan: part_time_plan.plan).active.any?
  end

  # Always remember when signing in with Devise.
  def remember_me
    Rails.configuration.always_remember_me
  end
end
