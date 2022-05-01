require "test_helper"

class BusinessTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper
  include BusinessesHelper

  test "conversations relationship doesn't include blocked ones" do
    business = businesses(:subscriber)
    conversation = business.conversations.create!(developer: developers(:one))
    assert_includes business.conversations, conversation

    conversation.touch(:developer_blocked_at)
    refute_includes business.conversations, conversation
  end

  test "should accept avatars of valid file formats" do
    business = businesses(:one)
    valid_formats = %w[image/png image/jpeg image/jpg]

    valid_formats.each do |file_format|
      business.avatar.stub :content_type, file_format do
        assert business.valid?, "#{file_format} should be a valid"
      end
    end
  end

  test "should reject avatars of invalid file formats" do
    business = businesses(:one)
    invalid_formats = %w[image/bmp image/gif video/mp4]

    invalid_formats.each do |file_format|
      business.avatar.stub :content_type, file_format do
        refute business.valid?, "#{file_format} should be an invalid format"
      end
    end
  end

  test "should enforce a maximum avatar file size" do
    business = businesses(:one)
    business.avatar.blob.stub :byte_size, 3.megabytes do
      refute business.valid?
    end
  end

  test "anonymizes the filename of the avatar" do
    business = Business.create!(business_attributes)
    assert_equal business.avatar.filename, "avatar.png"
  end

  test "should require new developer notifications" do
    business = businesses(:one)
    business.developer_notifications = nil
    refute business.valid?
  end

  test "should require new developer notifications in the given enum" do
    business = businesses(:one)
    invalid_values = [-1, 3, 4]

    invalid_values.each do |value|
      assert_raises ArgumentError, "#{value} should be an invalid argument to the enum" do
        business.developer_notifications = value
      end
    end

    valid_values = [0, 1, 2]

    valid_values.each do |value|
      business.developer_notifications = value

      assert business.valid?, "#{value} should be valid"
    end
  end

  test "should respond to expected states for new developer notifications" do
    business = businesses(:one)

    business.developer_notifications = 0
    assert business.no_developer_notifications?

    business.developer_notifications = 1
    assert business.daily_developer_notifications?

    business.developer_notifications = 2
    assert business.weekly_developer_notifications?
  end

  test "should define a default enum value for developer notifications" do
    business = Business.new

    assert business.no_developer_notifications?
  end
end
