class User < ApplicationRecord
  include APIAuthenticatable
  include PayCustomer

  devise :confirmable,
    :database_authenticatable,
    :recoverable,
    :registerable,
    :rememberable,
    :validatable

  has_many :hiring_agreement_signatures, class_name: "HiringAgreements::Signature", dependent: :destroy
  has_many :notification_tokens, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy
  has_one :business, dependent: :destroy
  has_one :developer, dependent: :destroy

  has_many :conversations, ->(user) {
    unscope(where: :user_id)
      .left_joins(:business, :developer)
      .where("businesses.user_id = ? OR developers.user_id = ?", user.id, user.id)
      .visible
  }
  has_many :unread_conversations,
    class_name: :Conversation,
    foreign_key: :user_with_unread_messages_id,
    inverse_of: :user_with_unread_messages

  scope :admin, -> { where(admin: true) }

  scope :search, ->(query) do
    query = "%#{query}%"
    left_outer_joins(:developer, :business)
      .where("email ILIKE ?", query)
      .or(where("developers.name ILIKE ?", query))
      .or(where("businesses.contact_name ILIKE ?", query))
      .or(where("businesses.company ILIKE ?", query))
  end

  # Always remember when signing in with Devise.
  def remember_me
    Rails.configuration.always_remember_me
  end

  def signed_hiring_agreement?
    HiringAgreements::Term.signed_by?(self)
  end

  def permissions
    Businesses::Permission.new(subscriptions)
  end
end
