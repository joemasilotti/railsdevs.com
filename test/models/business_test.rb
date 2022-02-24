require "test_helper"

class BusinessTest < ActiveSupport::TestCase
  setup do
    @business = businesses(:with_conversation)
  end

  test "successful business creation sends a notification to the admin" do
    assert_difference "Notification.count", 1 do
      Business.create!(valid_business_attributes)
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

  test "anonymizes the filename of the avatar" do
    developer = Business.create!(valid_business_attributes)
    assert_equal developer.avatar.filename, "avatar.jpg"
  end

  test "should require new developer notifications" do
    @business.developer_notifications = nil
    refute @business.valid?
  end

  test "should require new developer notifications in the given enum" do
    invalid_values = [-1, 3, 4]

    invalid_values.each do |value|
      assert_raises ArgumentError, "#{value} should be an invalid argument to the enum" do
        @business.developer_notifications = value
      end
    end

    valid_values = [0, 1, 2]

    valid_values.each do |value|
      @business.developer_notifications = value

      assert @business.valid?, "#{value} should be valid"
    end
  end

  test "should respond to expected states for new developer notifications" do
    @business.developer_notifications = 0
    assert @business.no_developer_notifications?

    @business.developer_notifications = 1
    assert @business.daily_developer_notifications?

    @business.developer_notifications = 2
    assert @business.weekly_developer_notifications?
  end

  test "should define a default enum value for developer notifications" do
    business = Business.new

    assert business.no_developer_notifications?
  end

  def valid_business_attributes
    {
      user: users(:empty),
      name: "Name",
      company: "Company",
      bio: "Bio",
      avatar: active_storage_blobs(:one),
      developer_notifications: :no
    }
  end
end
