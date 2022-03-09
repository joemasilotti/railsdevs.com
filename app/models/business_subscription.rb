module BusinessSubscription
  def self.new(plan)
    case plan.to_s.to_sym
    when :full_time then FullTime.new
    when :legacy then Legacy.new
    else PartTime.new
    end
  end

  def self.price_ids
    Rails.application.credentials.stripe[:price_ids]
  end
end
