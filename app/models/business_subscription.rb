module BusinessSubscription
  def self.new(plan)
    if plan.to_s.to_sym == :full_time
      FullTime.new
    else
      PartTime.new
    end
  end
end
