require "test_helper"

class SortButtonComponentTest < ViewComponent::TestCase
  test "enabled renders more prominently" do
    render_inline SortButtonComponent.new(title: "", enabled: false)
    assert_selector "button.text-gray-700"

    render_inline SortButtonComponent.new(title: "", enabled: true)
    assert_selector "button.font-medium.text-gray-900"
  end

  test "assigns passed in properties" do
    render_inline SortButtonComponent.new(title: "Save", name: :sort, value: :asc)
    assert_selector "button[type=submit][name=sort][value=asc]"
    assert_text "Save"
  end
end
