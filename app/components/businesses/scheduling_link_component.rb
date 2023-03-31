module Businesses
  class SchedulingLinkComponent < ApplicationComponent
    include LinksHelper

    private attr_reader :user, :conversation

    def initialize(user, conversation)
      @user = user
      @conversation = conversation
    end

    def render?
      conversation.business?(user) && scheduling_link.present?
    end

    def scheduling_link
      conversation.developer&.scheduling_link
    end

    def normalized_link
      normalized_href(scheduling_link)
    end
  end
end
