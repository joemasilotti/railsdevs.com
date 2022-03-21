require "test_helper"

class FieldErrorTagBuilderTest < ActiveSupport::TestCase
  setup do
    @instance = Struct.new(:error_message).new(["one error", "two error", "three error"])
  end

  test "replace only text color class" do
    html_tag = %(<label class="bg-gray-200 font-medium text-gray-200">Test Label</label>)
    builder = FieldErrorTagBuilder.new(html_tag, @instance)

    assert_equal html_tag.length - builder.color_free_tag.length, "text-gray-200".length
    assert_not builder.color_free_tag.include?("text-gray-200")
  end

  test "grabs correct closing tag index" do
    html_tag = %(<label class="bg-gray-200 font-medium">Test Label</label>)
    builder = FieldErrorTagBuilder.new(html_tag, @instance)
    actual_index = html_tag.index("</label")

    assert_equal builder.closing_tag_index, actual_index
  end

  test "inserts errors before closing tag" do
    html_tag = %(<label class="bg-gray-200 font-medium">Test Label</label>)
    builder = FieldErrorTagBuilder.new(html_tag, @instance)

    assert builder.error_field.index(@instance.error_message.first) < builder.error_field.index("</label>")
  end

  test "joins error messages into a sentence" do
    html_tag = %(<label>Test Label</label>)
    builder = FieldErrorTagBuilder.new(html_tag, @instance)

    assert_match(/one error, two error, and three error/, builder.error_field)
  end
end
