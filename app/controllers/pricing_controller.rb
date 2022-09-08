class PricingController < ApplicationController
  def show
    @stats = Pricing::Stats.new
    @testimonials = Testimonial.all
    render template
  end

  private

  def template
    if Feature.enabled?(:pricing_v3, user: current_user)
      "pricing/v3/show"
    elsif Feature.enabled?(:pricing_v2, user: current_user)
      "pricing/v2/show"
    else
      "pricing/v1/show"
    end
  end
end
