module Admin
  class SourceContributorToggleComponent < ApplicationComponent
    attr_reader :developer

    def initialize(developer)
      @developer = developer
    end
  end
end
