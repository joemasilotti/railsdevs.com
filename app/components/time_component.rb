class TimeComponent < ApplicationComponent
  attr_reader :time

  def initialize(time)
    @time = time
  end
end
