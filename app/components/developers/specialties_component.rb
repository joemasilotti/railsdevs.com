module Developers
  class SpecialtiesComponent < ApplicationComponent
    private attr_reader :specialties, :force_show

    def initialize(specialties, force_show: false)
      @specialties = specialties
      @force_show = force_show
    end

    def render?
      force_show || Feature.enabled?(:developer_specialty_querying)
    end
  end
end
