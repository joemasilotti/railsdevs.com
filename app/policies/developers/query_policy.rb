module Developers
  class QueryPolicy < ApplicationPolicy
    def permitted_attributes
      if Businesses::Permission.new(user&.payment_processor).active_subscription?
        default_attributes + paywalled_attributes
      else
        default_attributes
      end
    end

    private

    def default_attributes
      [
        :page,
        :include_not_interested,
        :sort,
        role_levels: [],
        role_types: [],
        utc_offsets: [],
        countries: []
      ]
    end

    def paywalled_attributes
      [
        :search_query
      ]
    end
  end
end
