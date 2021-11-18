class Conversation < ApplicationRecord
  validates :client_id, uniqueness: {scope: :developer_id}

  belongs_to :developer, class_name: "User", foreign_key: "developer_id"
  belongs_to :client, class_name: "User", foreign_key: "client_id"

  scope :of_company, ->(user) { where(client_id: user.id) }
  scope :of_developer, ->(user) { where(developer_id: user.id) }
end
