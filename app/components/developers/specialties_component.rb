module Developers
  class SpecialtiesComponent < ApplicationComponent
    private attr_reader :specialties

    def initialize(specialties)
      @specialties = specialties
    end

    def render?
      Feature.enabled?(:developer_specialties)
    end
  end
end
