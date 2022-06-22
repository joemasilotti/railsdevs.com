module Admin
  class DevelopersController < ApplicationController
    def index
      @context = DevelopersContext.new(title: "Developers", search_query: params[:search_query])
    end
  end
end
