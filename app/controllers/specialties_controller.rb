class SpecialtiesController < ApplicationController
  def index
    @query = params[:query]&.strip
    @specialties = Specialty.containing(@query)
  end
end
