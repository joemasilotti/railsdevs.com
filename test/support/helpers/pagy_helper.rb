module PagyHelper
  extend ActiveSupport::Concern

  included do
    def with_pagy_default_items(items, &block)
      default_items = Pagy::DEFAULT[:items]
      Pagy::DEFAULT[:items] = items
      yield
      Pagy::DEFAULT[:items] = default_items
    end
  end
end
