class User < ApplicationRecord
  devise :confirmable,
    :database_authenticatable,
    :recoverable,
    :registerable,
    :rememberable,
    :validatable

  has_one :developer
  has_many :notifications, as: :recipient
  has_many :hiring_leads, class_name: "Conversation", foreign_key: "client_id"
  has_many :work_leads, class_name: "Conversation", foreign_key: "developer_id"

  validates :company, presence: true, inclusion: {in: [true, false]}

  scope :admin, -> { where(admin: true) }

  def company?
    company
  end
end
