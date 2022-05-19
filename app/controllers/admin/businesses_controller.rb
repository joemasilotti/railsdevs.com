module Admin
  class BusinessesController < ApplicationController
    def index
      @context = BusinessesContext.new(title: "Businesses", search_query: params[:search_query])
    end
  end
end
