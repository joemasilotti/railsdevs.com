module Admin
  class CheckComponent < ApplicationComponent
    attr_reader :checked_title, :unchecked_title

    def initialize(checked_title, unchecked_title = nil, checked: true)
      @checked_title = checked_title
      @unchecked_title = unchecked_title
      @checked = checked
    end

    def checked?
      !!@checked
    end
  end
end
