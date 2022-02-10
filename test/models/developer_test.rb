require "test_helper"

class DeveloperTest < ActiveSupport::TestCase
  setup do
    @developer = developers :available
  end

  test "unspecified availability" do
    @developer.available_on = nil

    assert_equal "unspecified", @developer.availability_status
    assert @developer.available_unspecified?
  end

  test "available in a future date" do
    @developer.available_on = Date.current + 2.weeks

    assert_equal "in_future", @developer.availability_status
    assert @developer.available_in_future?
  end

  test "available from a past date" do
    @developer.available_on = Date.current - 3.weeks

    assert_equal "now", @developer.availability_status
    assert @developer.available_now?
  end

  test "available from today" do
    @developer.available_on = Date.current

    assert_equal "now", @developer.availability_status
    assert @developer.available_now?
  end

  test "is valid" do
    assert Developer.new(valid_developer_attributes).valid?
  end

  test "invalid without user" do
    developer = Developer.new(user: nil)

    refute developer.valid?
    assert_not_nil developer.errors[:user]
  end

  test "invalid without name" do
    user = users(:with_available_profile)
    developer = Developer.new(user:, name: nil)

    refute developer.valid?
    assert_not_nil developer.errors[:name]
  end

  test "invalid without hero" do
    user = users(:with_available_profile)
    developer = Developer.new(user:, hero: nil)

    refute developer.valid?
    assert_not_nil developer.errors[:hero]
  end

  test "invalid without bio" do
    user = users(:with_available_profile)
    developer = Developer.new(user:, bio: nil)

    refute developer.valid?
    assert_not_nil developer.errors[:bio]
  end

  test "available scope is only available developers" do
    travel_to Time.zone.local(2021, 5, 4)

    developers = Developer.available

    assert_includes developers, developers(:available)
    refute_includes developers, developers(:unavailable)
  end

  test "successful profile creation sends a notification to the admins" do
    assert_difference "Notification.count", 1 do
      Developer.create!(valid_developer_attributes)
    end

    assert_equal Notification.last.type, NewDeveloperProfileNotification.name
    assert_equal Notification.last.recipient, users(:admin)
  end

  test "should accept avatars of valid file formats" do
    valid_formats = %w[image/png image/jpeg image/jpg]

    valid_formats.each do |file_format|
      @developer.avatar.stub :content_type, file_format do
        assert @developer.valid?, "#{file_format} should be a valid"
      end
    end
  end

  test "should reject avatars of invalid file formats" do
    invalid_formats = %w[image/bmp image/gif video/mp4]

    invalid_formats.each do |file_format|
      @developer.avatar.stub :content_type, file_format do
        refute @developer.valid?, "#{file_format} should be an invalid format"
      end
    end
  end

  test "should enforce a maximum avatar file size" do
    @developer.avatar.blob.stub :byte_size, 3.megabytes do
      refute @developer.valid?
    end
  end

  test "should accept cover images of valid file formats" do
    valid_formats = %w[image/png image/jpeg image/jpg]

    valid_formats.each do |file_format|
      @developer.cover_image.stub :content_type, file_format do
        assert @developer.valid?, "#{@developer.errors.full_messages} should be a valid"
      end
    end
  end

  test "should reject cover images of invalid file formats" do
    invalid_formats = %w[image/bmp video/mp4]

    invalid_formats.each do |file_format|
      @developer.cover_image.stub :content_type, file_format do
        refute @developer.valid?, "#{file_format} should be an invalid format"
      end
    end
  end

  test "should enforce a maximum cover image file size" do
    @developer.cover_image.blob.stub :byte_size, 11.megabytes do
      refute @developer.valid?
    end
  end

  test "updating a profile doesn't require search status nor time zone" do
    developer = developers(:with_conversation)
    assert_nil developer.search_status
    assert_nil developer.time_zone

    assert developer.valid?
  end

  test "normalizes social media profile input" do
    developer = Developer.new(valid_developer_attributes)
    developer.github = "https://github.com/joemasilotti"
    developer.save!
    assert_equal developer.github, "joemasilotti"
  end

  def valid_developer_attributes
    {
      user: users(:empty),
      name: "Name",
      hero: "Hero",
      bio: "Bio",
      avatar: active_storage_blobs(:one),
      time_zone: "Pacific Time (US & Canada)"
    }
  end
end
