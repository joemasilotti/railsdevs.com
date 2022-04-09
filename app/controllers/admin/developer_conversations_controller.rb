module Admin
  class DeveloperConversationsController < ConversationsController
    def index
      super
      @title = "#{developer.name}'s conversations"
      render "admin/conversations/index"
    end

    private

    def developer
      @business ||= Developer.find(params[:developer_id])
    end

    def all_conversations
      @all_conversations ||= developer.conversations
    end
  end
end
