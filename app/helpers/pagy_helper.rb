module PagyHelper
  include Pagy::Frontend

  def pagy_links(**args, &block)
    tag.div(id: "pagy-links", **args, data: {controller: "toggle", toggle_on_load_value: true, toggle_visibility_class: "invisible", toggle_target: "element"}, &block)
  end
end
