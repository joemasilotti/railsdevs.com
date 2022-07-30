class InboundEmail < ApplicationRecord
  validates :postmark_message_id, :payload, presence: true

  belongs_to :message, optional: true
end
