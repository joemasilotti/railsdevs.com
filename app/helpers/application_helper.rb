module ApplicationHelper
  def hotwire_livereload_tags
    super if Rails.env.development?
  end
end
