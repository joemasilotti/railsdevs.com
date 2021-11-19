class ConversationComponent < ViewComponent::Base
  def initialize(conversation:, user:)
    @conversation = conversation
    @recipient_user = user.company? ? conversation.developer : conversation.client
  end

  def recipient_avatar
    begin
      @recipient_user.avatar
    rescue
      "joe.jpg"
    end
  end

  def recipient_header
    @recipient_user.company? ? @recipient_user.email : @recipient_user.developer.hero
  end
end
