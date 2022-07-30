class InboundEmail < ApplicationRecord
  belongs_to :message, optional: true

  validates :postmark_message_id, :payload, presence: true
end
