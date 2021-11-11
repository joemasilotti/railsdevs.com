module PagyHelper
  include Pagy::Frontend

  def pagy_links(**args, &block)
    tag.div(id: "pagy-links", **args, data: {pagination_target: "links"}, &block)
  end
end
