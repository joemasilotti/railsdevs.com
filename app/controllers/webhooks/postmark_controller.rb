module Webhooks
  class PostmarkController < ApplicationController
    def create
      InboundEmailJob.perform_later(payload)
    end

    private

    def payload
      params.except(*%i[postmark controller action]).to_unsafe_h
    end
  end
end
