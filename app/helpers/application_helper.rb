module ApplicationHelper
  def hotwire_livereload_tags
    super if Rails.env.development?
  end

  def stylesheet_design_tag
    stylesheet = Feature.enabled?(:redesign) ? "redesign" : "application"
    stylesheet_link_tag stylesheet, media: "all", "data-turbo-track": "reload"
  end
end
