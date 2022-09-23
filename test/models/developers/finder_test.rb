require "test_helper"

class Developers::FinderTest < ActiveSupport::TestCase
  setup do
    @developer = developers(:one)
  end

  test "should find a developer by hashid" do
    finder = Developers::Finder.new(id: @developer.hashid)

    assert_equal finder.developer, @developer
    refute finder.should_redirect?
  end

  test "redirect should be true when given an id" do
    finder = Developers::Finder.new(id: @developer.id)

    assert finder.should_redirect?
  end

  test "should find a developer if feature is disabled" do
    Feature.stub(:enabled?, false) do
      finder = Developers::Finder.new(id: @developer.id)

      assert_equal finder.developer, @developer
      refute finder.should_redirect?

      finder = Developers::Finder.new(id: @developer.hashid)

      assert_equal finder.developer, @developer
      refute finder.should_redirect?
    end
  end
end
