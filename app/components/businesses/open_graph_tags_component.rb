module Businesses
  class OpenGraphTagsComponent < OpenGraphTagsComponent
    def initialize(business:)
      @business = business
    end

    def title
      @business.company
    end

    def description
      @business.bio
    end

    def url
      business_url(@business)
    end

    def image
      rails_blob_url(@business.avatar) if @business.avatar.attached?
    end
  end
end
