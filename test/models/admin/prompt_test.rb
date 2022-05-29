require "test_helper"

class Admin::PromptTest < ActiveSupport::TestCase
  setup do
    @prompt = Admin::Prompt.new(
      name: "This is test prompt"
    )
  end

  test "should be valid" do
    assert @prompt.valid?
  end

  test "should require the presence of a name" do
    @prompt.name = ""

    refute @prompt.valid?
  end

  test "should limit the max length of a name of a prompt to 140 characters" do
    @prompt.name = "a" * 140
    assert @prompt.valid?

    @prompt.name += "a"
    refute @prompt.valid?
  end

  test "should default active to false" do
    @prompt.save

    refute @prompt.active?
  end
end
