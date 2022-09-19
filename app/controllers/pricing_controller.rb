class PricingController < ApplicationController
  def show
    @stats = Pricing::Stats.new
    @testimonials = Testimonial.all
    render template
  end

  private

  def template
    "pricing/v3/show"
  end
end
