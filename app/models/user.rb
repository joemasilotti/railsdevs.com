class User < ApplicationRecord
  devise :confirmable,
    :database_authenticatable,
    :recoverable,
    :registerable,
    :rememberable,
    :validatable

  has_many :notifications, as: :recipient, dependent: :destroy

  has_many :account_users, dependent: :destroy
  has_many :accounts, through: :account_users, autosave: true

  scope :admin, -> { where(admin: true) }

  before_destroy :mark_accounts_for_destruction

  def active_business_subscription?
    subscriptions.active.any?
  end

  def active_legacy_business_subscription?
    legacy_plan = BusinessSubscription::Legacy.new
    subscriptions.for_name(legacy_plan.name).active.any?
  end

  private

  def mark_accounts_for_destruction
    accounts.map(&:mark_for_destruction)
  end
end
