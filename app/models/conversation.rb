class Conversation < ApplicationRecord
  validates :client_id, uniqueness: {scope: :developer_id}

  belongs_to :developer, class_name: "User", foreign_key: "developer_id"
  belongs_to :client, class_name: "User", foreign_key: "client_id"
end
