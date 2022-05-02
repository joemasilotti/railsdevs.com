require "test_helper"

class DeveloperTest < ActiveSupport::TestCase
  include DevelopersHelper

  setup do
    @developer = developers(:one)
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
    assert Developer.new(developer_attributes).valid?
  end

  test "invalid without user" do
    developer = Developer.new(user: nil)

    refute developer.valid?
    assert_not_nil developer.errors[:user]
  end

  test "invalid without name" do
    user = users(:empty)
    developer = Developer.new(user:, name: nil)

    refute developer.valid?
    assert_not_nil developer.errors[:name]
  end

  test "invalid without hero" do
    user = users(:empty)
    developer = Developer.new(user:, hero: nil)

    refute developer.valid?
    assert_not_nil developer.errors[:hero]
  end

  test "invalid without bio" do
    user = users(:empty)
    developer = Developer.new(user:, bio: nil)

    refute developer.valid?
    assert_not_nil developer.errors[:bio]
  end

  test "available scope is only developers available today or earlier" do
    developers(:one).update!(available_on: Time.zone.local(2021, 1, 1))
    developers(:prospect).update!(available_on: Time.zone.local(2022, 1, 1))

    travel_to Time.zone.local(2021, 5, 4) do
      developers = Developer.available
      assert_includes developers, developers(:one)
      refute_includes developers, developers(:prospect)
    end
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

  test "anonymizes the filename of the avatar" do
    developer = Developer.create!(developer_attributes)
    assert_equal developer.avatar.filename, "avatar.jpg"
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

  test "updating a profile doesn't require search status" do
    @developer.search_status = nil
    assert_nil @developer.search_status
    assert @developer.valid?
  end

  test "normalizes social media profile input" do
    developer = Developer.new(developer_attributes)
    developer.github = "https://github.com/joemasilotti"
    developer.save!
    assert_equal developer.github, "joemasilotti"
  end

  test "missing fields when search status is blank" do
    refute @developer.missing_fields?

    @developer.search_status = nil
    assert @developer.missing_fields?
  end

  test "missing fields when location country is blank" do
    refute @developer.missing_fields?

    @developer.location.country = nil
    assert @developer.missing_fields?
  end

  test "missing fields when role level is all blank" do
    refute @developer.missing_fields?

    @developer.build_role_level
    assert @developer.missing_fields?
  end

  test "missing fields when role type is all blank" do
    refute @developer.missing_fields?

    @developer.build_role_type
    assert @developer.missing_fields?
  end

  test "missing fields available on is blank" do
    refute @developer.missing_fields?

    @developer.available_on = nil
    assert @developer.missing_fields?
  end

  test "visible scope includes developers who are not invisible and haven't set their search status" do
    assert_includes Developer.visible, developers(:one)

    developers(:one).update!(search_status: :invisible)
    refute_includes Developer.visible, developers(:one)

    developers(:one).update!(search_status: nil)
    assert_includes Developer.visible, developers(:one)
  end

  test "featured developers were featured within the last week" do
    developer = developers(:one)
    refute_includes Developer.featured, developer

    developer.feature!
    assert_includes Developer.featured, developer

    travel 7.days
    assert_includes Developer.featured, developer

    travel 1.second
    refute_includes Developer.featured, developer

    travel_back
  end
end
