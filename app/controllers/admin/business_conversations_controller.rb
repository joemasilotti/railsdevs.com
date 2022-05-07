module Admin
  class BusinessConversationsController < ConversationsController
    def index
      super
      render "admin/conversations/index"
    end

    private

    def entity
      @entity ||= Business.find(params[:business_id])
    end

    def title
      entity.company
    end
  end
end
