module ApplicationHelper
  def hotwire_livereload_tags
    super if Rails.env.development?
  end

  def resolve_locale(locale)
    locale == I18n.default_locale ? nil : locale
  end
end
