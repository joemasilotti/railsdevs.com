class AvailabilityComponent < ApplicationComponent
  def initialize(developer:, show_unavailable_icon: false)
    @developer = developer
    @show_unavailable_icon = show_unavailable_icon
  end

  def show_unavailable_icon?
    !!@show_unavailable_icon
  end

  def available?
    @developer.available_now?
  end

  def date
    @developer.available_on&.to_s(:db)
  end

  def date_in_words
    return unless @developer.available_in_future?

    time_ago_in_words(@developer.available_on)
  end
end
