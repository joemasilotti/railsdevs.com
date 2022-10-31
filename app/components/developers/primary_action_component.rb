module Developers
  class PrimaryActionComponent < ApplicationComponent
    attr_reader :user, :developer, :business

    def initialize(user:, developer:, business:, public_key:)
      @user = user
      @developer = developer
      @business = business
      @public_key = public_key
    end

    def owner?
      user&.developer == developer
    end

    def conversation
      Conversation.find_by(developer:, business:)
    end

    def share_url
      developer.share_url
    end
  end
end
