class Notification < ApplicationRecord
  include Noticed::Model

  belongs_to :recipient, polymorphic: true

  def conversation
    message.conversation_id
  end

  def message
    params[:message]
  end
end
