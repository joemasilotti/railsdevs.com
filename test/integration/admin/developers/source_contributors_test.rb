require "test_helper"

class Admin::Developers::SourceContributorsTest < ActionDispatch::IntegrationTest
  test "activates a source contributor" do
    developer = developers(:one)
    sign_in users(:admin)

    post admin_developer_source_contributors_path(developer)

    assert developer.reload.source_contributor?
  end

  test "deactivates a source contributor" do
    developer = developers(:one)
    developer.update!(source_contributor: true)
    sign_in users(:admin)

    delete admin_developer_source_contributors_path(developer)

    refute developer.reload.source_contributor?
  end
end
