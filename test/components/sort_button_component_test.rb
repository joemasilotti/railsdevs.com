require "test_helper"

class SortButtonComponentTest < ViewComponent::TestCase
  test "enabled renders more prominently" do
    render_inline new_component(active: false)
    assert_selector "button.text-gray-700"

    render_inline new_component(active: true)
    assert_selector "button.font-medium.text-gray-900"
  end

  test "assigns passed in properties" do
    render_inline new_component(title: "Save", name: :sort, value: :asc)
    assert_selector "button[type=submit][name=sort][value=asc]"
    assert_text "Save"
  end

  def new_component(title: "", name: nil, value: nil, active: false, form_id: nil)
    SortButtonComponent.new(title:, name:, value:, active:, form_id:)
  end
end
