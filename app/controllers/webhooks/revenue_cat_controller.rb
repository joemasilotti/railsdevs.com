module Webhooks
  class RevenueCatController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create

    def create
      if request.headers["Authorization"] == webhook_authorization
        RevenueCatSubscriptionsSyncJob.perform_later(event)
        head :ok
      else
        head :unauthorized
      end
    end

    private

    def webhook_authorization
      Rails.application.credentials.revenue_cat.webhook_authorization
    end

    def event
      params["event"].to_unsafe_hash
    end
  end
end
