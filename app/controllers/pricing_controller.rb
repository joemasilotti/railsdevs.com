class PricingController < ApplicationController
  def show
    @stats = Pricing::Stats.new
    @testimonials = BusinessTestimonial.all
  end
end
