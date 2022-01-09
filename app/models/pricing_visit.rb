class PricingVisit
  SESSION_KEY = "visits.pricing".freeze

  attr_reader :session

  def initialize(session)
    @session = session
  end

  def track_visit
    session[SESSION_KEY] = true
  end

  def visited?
    ActiveModel::Type::Boolean.new.cast(session[SESSION_KEY])
  end
end
