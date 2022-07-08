module Admin
  class ImpersonatesController < ApplicationController
    def create
      user = User.find_by!(email: params[:email])
      impersonate_user(user)
      redirect_to root_path
    end

    def show
    end

    def destroy
      stop_impersonating_user
      redirect_to root_path
    end
  end
end
