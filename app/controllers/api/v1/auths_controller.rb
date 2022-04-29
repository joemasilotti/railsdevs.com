module API
  module V1
    class AuthsController < ApplicationController
      def create
        if (user = User.valid_credentials?(params[:email], params[:password]))
          sign_in user
          render json: {token: user.authentication_token}
        else
          render json: {error: error_message}, status: :unauthorized
        end
      end

      def destroy
        sign_out(current_user)
        render json: {}
      end

      private

      def error_message
        I18n.t("devise.failure.invalid", authentication_keys: [:email])
      end
    end
  end
end
