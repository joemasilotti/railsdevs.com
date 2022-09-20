class PricingController < ApplicationController
  def show
    @stats = Pricing::Stats.new
    @testimonials = Testimonial.all
  end
end
