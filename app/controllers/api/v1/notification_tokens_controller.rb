module API
  module V1
    class NotificationTokensController < ApplicationController
      def create
        current_user.notification_tokens.find_or_create_by!(
          token: params[:token],
          platform: params[:platform]
        )
        render json: {}, status: :created
      end
    end
  end
end
