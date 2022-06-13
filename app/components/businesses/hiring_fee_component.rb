module Businesses
  class HiringFeeComponent < ApplicationComponent
    private attr_reader :user, :conversation

    def initialize(user, conversation)
      @user = user
      @conversation = conversation
    end

    def render?
      Businesses::Permission.new(user.subscriptions).pays_hiring_fee? &&
        conversation.hiring_fee_eligible?
    end

    def developer
      conversation.developer.name
    end

    def recipient
      Rails.configuration.emails.support!
    end

    def subject
      t(".subject.hired")
    end

    def body
      t(".body.hired", developer: developer)
    end
  end
end
