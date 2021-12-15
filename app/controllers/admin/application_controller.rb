module Admin
  class ApplicationController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin!

    protected

    def require_admin!
      redirect_to root_path unless current_user.admin?
    end
  end
end
