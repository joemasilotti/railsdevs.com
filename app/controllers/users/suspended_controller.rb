module Users
  class SuspendedController < ApplicationController
    skip_before_action :redirect_suspended_accounts

    def show
    end
  end
end
