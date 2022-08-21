module Admin
  class UsersController < ApplicationController
    include Pagy::Backend

    def index
      @query = params[:query]
      @pagy, @users = pagy(users(@query))
    end

    private

    def users(query)
      User.filter_by_email(query)
        .includes(developer: {avatar_attachment: :blob}, business: {avatar_attachment: :blob})
        .order(:email)
    end
  end
end
