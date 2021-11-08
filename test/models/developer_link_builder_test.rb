require "test_helper"

class DeveloperLinkBuilderTest < ActiveSupport::TestCase
  test "builds the developer's website url" do
    developer = developers(:one)
    url = DeveloperLinkBuilder.new({developer_id: developer.id, field: :website}).url
    assert_equal developer.website, url
  end

  test "builds the developer's website, adding https if no scheme" do
    developer = developers(:two)
    url = DeveloperLinkBuilder.new({developer_id: developer.id, field: :website}).url
    assert_equal "https://google.com", url
  end

  test "builds a mailto: link for the developer's user's email" do
    developer = developers(:one)
    url = DeveloperLinkBuilder.new({developer_id: developer.id, field: :email}).url
    assert_equal "mailto:one@example.com", url
  end

  test "builds the developer's GitHub url" do
    developer = developers(:one)
    url = DeveloperLinkBuilder.new({developer_id: developer.id, field: :github}).url
    assert_equal "https://github.com/OneDeveloper", url
  end

  test "builds the developer's Twitter url" do
    developer = developers(:one)
    url = DeveloperLinkBuilder.new({developer_id: developer.id, field: :twitter}).url
    assert_equal "https://twitter.com/OneTweeter", url
  end

  test "builds the developer's LinkedIn url" do
    developer = developers(:one)
    url = DeveloperLinkBuilder.new({developer_id: developer.id, field: :linkedin}).url
    assert_equal "https://www.linkedin.com/in/OneNetworker", url
  end

  def options(field)
    {developer_id: @developer.id, field: field}
  end
end
