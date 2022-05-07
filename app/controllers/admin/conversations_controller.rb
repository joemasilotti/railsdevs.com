module Admin
  class ConversationsController < ApplicationController
    def index
      @context = ConversationsContext.new(entity, title:, options: params)
    end

    private

    def entity
      nil
    end

    def title
      t("admin.conversations.index.title")
    end
  end
end
