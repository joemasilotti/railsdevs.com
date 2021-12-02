class ConversationPolicy < ApplicationPolicy
  class MissingBusiness < ApplicationError; end

  class AlreadyExists < ApplicationError
    attr_reader :conversation

    def initialize(conversation)
      @conversation = conversation
    end
  end

  def create?
    raise MissingBusiness if user.business.blank?
    if (conversation = existing_conversation)
      raise AlreadyExists.new(conversation)
    end
    true
  end

  def show?
    raise MissingBusiness if user.business.blank?
    true
  end

  private

  def conversation_exists?
    Conversation.exists?(record.attributes.slice(*%w[business_id developer_id]))
  end

  def existing_conversation
    Conversation.find_by(record.attributes.slice(*%w[business_id developer_id]))
  end
end
