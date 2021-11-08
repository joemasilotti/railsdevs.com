class AvailabilityComponent < ViewComponent::Base
  def initialize(developer:)
    @developer = developer
  end

  def date
    @developer.available_on&.to_s(:db)
  end

  def date_in_words
    return unless @developer.available_in_future?

    time_ago_in_words(@developer.available_on)
  end
end
