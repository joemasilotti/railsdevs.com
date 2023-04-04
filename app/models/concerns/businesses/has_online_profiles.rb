module Businesses
  module HasOnlineProfiles
    extend ActiveSupport::Concern
    include UrlAttribute

    included do
      url_attribute :website
    end
  end
end
