module Admin
  class UsersController < ApplicationController
    include Pagy::Backend

    def index
      @query = params[:query]
      @pagy, @users = pagy(users(@query))
    end

    private

    def users(query)
      User.filter_by_email(query).order(:email)
    end
  end
end
