module Developers
  class PrimaryActionComponent < ApplicationComponent
    attr_reader :user, :developer, :business

    def initialize(user:, developer:, business:)
      @user = user
      @developer = developer
      @business = business
    end

    def owner?
      user&.developer == developer
    end

    def conversation
      Conversation.find_by(developer:, business:)
    end
  end
end
