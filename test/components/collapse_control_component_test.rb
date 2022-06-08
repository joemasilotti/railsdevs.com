require "test_helper"

class CollapseControlComponentTest < ViewComponent::TestCase
  setup do
    @title = "foo"
  end

  test "renders text-xs for title if is a subcomponent" do
    render_inline CollapseControlComponent.new(@title, subcomponent: true)

    assert_selector 'span[class="font-medium text-gray-900 text-xs"]'
  end

  test "does not render text-xs for title if is not a subcomponent" do
    render_inline CollapseControlComponent.new(@title)

    assert_no_selector 'span[class="font-medium text-gray-900 text-xs"]'
  end
end
