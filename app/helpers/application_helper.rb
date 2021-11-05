module ApplicationHelper
  def last_page_target
    tag.span(class: 'hidden', data: {pagination_target: 'lastPage'})
  end
end
