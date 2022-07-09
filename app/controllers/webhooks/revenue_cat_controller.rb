module Webhooks
  class RevenueCatController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create

    def create
      if request.headers["Authorization"] == webhook_authorization
        RevenueCatSubscriptionsSyncJob.perform_later(user_id)
        head :ok
      else
        head :unauthorized
      end
    end

    private

    def webhook_authorization
      Rails.application.credentials.revenue_cat.webhook_authorization
    end

    def user_id
      params.require(:event).permit(:app_user_id)[:app_user_id]
    end
  end
end
