module Developers
  class SpecialtiesComponent < ApplicationComponent
    private attr_reader :specialties

    def initialize(specialties)
      @specialties = specialties
    end
  end
end
