class Notification < ApplicationRecord
  include Noticed::Model

  belongs_to :recipient, polymorphic: true

  def conversation
    message.conversation
  end

  def message
    params[:message]
  end
end
