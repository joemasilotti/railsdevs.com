class ExpensesController < ApplicationController
  def show
  end

  private

  def renderer
    Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  def file(name)
    Rails.root.join("app/views/expenses/show.#{name}.md")
  end
end
