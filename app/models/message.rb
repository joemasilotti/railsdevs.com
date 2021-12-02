class Message < ApplicationRecord
  belongs_to :conversation
  has_one :developer, through: :conversation
  has_one :business, through: :conversation

  validates :body, presence: true
end
