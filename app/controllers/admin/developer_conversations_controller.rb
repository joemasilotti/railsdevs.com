module Admin
  class DeveloperConversationsController < ConversationsController
    def index
      super
      render "admin/conversations/index"
    end

    private

    def entity
      @entity ||= Developer.find(params[:developer_id])
    end

    def title
      entity.name
    end
  end
end
