class Conversation::Block < ApplicationRecord
  belongs_to :conversation
  belongs_to :blocker, class_name: "User"
  belongs_to :blockee, class_name: "User"
end
