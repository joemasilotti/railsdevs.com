class Conversation < ApplicationRecord
  belongs_to :developer
  belongs_to :client
end
