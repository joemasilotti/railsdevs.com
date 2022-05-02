module BusinessSubscription
  class UnknownPrice < StandardError; end

  def self.new(plan)
    case plan.to_s.to_sym
    when :full_time then FullTime.new
    when :legacy then Legacy.new
    else PartTime.new
    end
  end

  def self.from(price)
    if FullTime.new.plan == price
      FullTime.new
    elsif PartTime.new.plan == price
      PartTime.new
    elsif Legacy.new.plan == price
      Legacy.new
    elsif Free.new.plan == price
      Free.new
    else
      raise UnknownPrice.new
    end
  end

  def self.price_ids
    Rails.application.credentials.dig(:stripe, :price_ids) || development_price_ids
  end

  # For when Stripe price IDs aren't set in the environment's credentials.
  def self.development_price_ids
    {
      part_time_plan: "price_part_time_plan",
      full_time_plan: "price_full_time_plan",
      legacy_plan: "price_legacy_plan"
    }
  end
end
