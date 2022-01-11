module PagyHelper
  include Pagy::Frontend

  def pagy_links(**args, &block)
    tag.div(id: "pagy-links", **args, data: {controller: "toggle", toggle_close_class: "hidden", toggle_target: "element"}, &block)
  end
end
