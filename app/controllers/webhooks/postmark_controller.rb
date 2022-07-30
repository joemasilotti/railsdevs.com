module Webhooks
  class PostmarkController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create

    def create
      InboundEmailJob.perform_later(payload)
    end

    private

    def payload
      params.except(*%i[postmark controller action]).to_unsafe_h
    end
  end
end
