require "test_helper"

class PublicProfileTest < ActiveSupport::TestCase
  include UrlHelpersWithDefaultUrlOptions

  setup do
    @developer = developers(:one)
  end

  test "Should generate public share URL for developer" do
    share_url = @developer.share_url
    assert_equal share_url, developer_public_url(@developer, @developer.public_profile_key)
  end

  test "Should return true if valid public profile key" do
    public_profile_key = SecureRandom.hex(4)
    @developer.update!(public_profile_key: public_profile_key)
    assert @developer.valid_public_profile_access?(public_profile_key)
  end

  test "Should return false if public profile key does not match" do
    public_profile_key = SecureRandom.hex(4)
    refute @developer.valid_public_profile_access?(public_profile_key)
  end
end
