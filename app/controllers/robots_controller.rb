class RobotsController < ApplicationController
  layout false

  def index
    @bucket = Rails.application.credentials.dig(:aws, :sitemaps_bucket)
    @region = Rails.application.credentials.dig(:aws, :region)
  end
end
