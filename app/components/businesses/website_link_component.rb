module Businesses
  class WebsiteLinkComponent < ApplicationComponent
    include LinksHelper
    attr_reader :business

    def initialize(business)
      @business = business
    end

    def website_url
      return unless website_present?

      normalized_href(business.website)
    end

    def website_present?
      business.website.present?
    end

    def company_name
      business.company
    end
  end
end
