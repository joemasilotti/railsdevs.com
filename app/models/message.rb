class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, polymorphic: true
  has_one :developer, through: :conversation
  has_one :business, through: :conversation

  validates :body, presence: true

  def sender?(user)
    [user.developer, user.business].include?(sender)
  end
end
