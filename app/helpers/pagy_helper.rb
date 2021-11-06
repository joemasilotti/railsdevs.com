module PagyHelper
  include Pagy::Frontend

  def pagy_links(**args, &block)
    tag.div(class: "invisible opacity-0 w-0 h-0", id: "pagy-links", **args, data: {pagination_target: "links"}, &block)
  end
end
