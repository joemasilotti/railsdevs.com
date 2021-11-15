require "test_helper"

class TagColorManipulatorTest < ActiveSupport::TestCase
  test "replace only text color class" do
    html_tag = %(<label class="bg-gray-200 font-medium text-gray-200">Test Label</label>)
    tag_color_manipulator = TagColorManipulator.new(html_tag)
    color_free_html_tag = tag_color_manipulator.remove_text_color

    assert_equal html_tag.length - color_free_html_tag.length, "text-gray-200".length
    assert_not color_free_html_tag.include?("text-gray-200")
  end
end
