class PricingController < ApplicationController
  after_action :track_pricing_visit

  def show
    @cta = stripe_checkout_path(developer: params[:developer])
  end

  private

  def track_pricing_visit
    PricingVisit.new(session).track_visit
  end
end
