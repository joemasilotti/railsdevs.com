module Admin
  class BusinessConversationsController < ConversationsController
    def index
      super
      @title = "#{business.company}'s conversations"
      render "admin/conversations/index"
    end

    private

    def business
      @business ||= Business.find(params[:business_id])
    end

    def all_conversations
      @all_conversations ||= business.conversations
    end
  end
end
