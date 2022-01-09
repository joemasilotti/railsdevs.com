require "test_helper"

class BusinessTest < ActiveSupport::TestCase
  setup do
    @business = businesses(:with_conversation)
  end

  test "successful business creation sends a notification to the admin" do
    user = users(:empty)

    assert_difference "Notification.count", 1 do
      Business.create!(name: "name", company: "company", bio: "bio", user:)
    end

    assert_equal Notification.last.type, NewBusinessNotification.name
    assert_equal Notification.last.recipient, users(:admin)
  end

  test "conversations relationship doesn't include blocked ones" do
    assert @business.conversations.include?(conversations(:one))
    refute @business.conversations.include?(conversations(:blocked))
  end

  test "should accept avatars of valid file formats" do
    valid_formats = %w[image/png image/jpeg image/jpg]

    valid_formats.each do |file_format|
      @business.avatar.stub :content_type, file_format do
        assert @business.valid?, "#{file_format} should be a valid"
      end
    end
  end

  test "should reject avatars of invalid file formats" do
    invalid_formats = %w[image/bmp image/gif video/mp4]

    invalid_formats.each do |file_format|
      @business.avatar.stub :content_type, file_format do
        refute @business.valid?, "#{file_format} should be an invalid format"
      end
    end
  end

  test "should enforce a maximum avatar file size" do
    @business.avatar.blob.stub :byte_size, 3.megabytes do
      refute @business.valid?
    end
  end
end
