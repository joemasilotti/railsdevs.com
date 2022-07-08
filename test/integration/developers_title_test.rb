require "test_helper"

class DevelopersTitleTest < ActionDispatch::IntegrationTest
  include MetaTagsHelper

  test "all generated URLs render unique titles" do
    titles = []
    Developers::QueryPath.all.each do |path|
      get path
      title = html_document.title
      refute_includes titles, title

      titles << title
    end
    assert_operator titles.count, :>, 0
  end
end
