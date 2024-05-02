module Admin
  class SpecialtiesController < ApplicationController
    def index
      @specialties = Specialty.includes(developers: :user)
        .order(developers_count: :desc).visible
    end

    def new
      @specialty = Specialty.new
    end

    def create
      @specialty = Specialty.new(specialty_params)
      if @specialty.save
        redirect_to admin_specialty_path(@specialty), notice: t(".created")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show
      @specialty = Specialty.find(params[:id])
    end

    def edit
      @specialty = Specialty.find(params[:id])
    end

    def update
      @specialty = Specialty.find(params[:id])
      if @specialty.update(specialty_params)
        redirect_to admin_specialty_path(@specialty), notice: t(".updated")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      Specialty.find(params[:id]).destroy
      redirect_to admin_specialties_path
    end

    private

    def specialty_params
      params.require(:specialty).permit(:name)
    end
  end
end
