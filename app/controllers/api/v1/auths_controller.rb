module API
  module V1
    class AuthsController < ApplicationController
      skip_before_action :authenticate_token!, only: :create

      def create
        if (user = User.valid_credentials?(params[:email], params[:password]))
          sign_in(user)
          render json: {token: user.authentication_token, id: user.id}
        else
          render json: {error: error_message}, status: :unauthorized
        end
      end

      def destroy
        destroy_notification_token
        sign_out(current_user)
        render json: {}
      end

      private

      def error_message
        I18n.t("devise.failure.invalid", authentication_keys: :email)
      end

      def destroy_notification_token
        current_user.notification_tokens.where(token: params[:token]).destroy_all
      end
    end
  end
end
