module ApplicationHelper
  def hotwire_livereload_tags
    super if Rails.env.development?
  end

  def round_to_lower_multiple_of_ten(number)
    return number - 1 if number <= 10

    modulo = number % 10
    number - modulo
  end
end
