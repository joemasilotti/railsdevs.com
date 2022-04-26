require "test_helper"

class InvisibleDeveloperTest < ActiveSupport::TestCase
  setup do
    @developer = developers(:one)
  end

  test "sets the developer's status to invisible" do
    InvisibleDeveloper.new(@developer).mark
    assert @developer.invisible?
  end

  test "notifies the dev when they are marked as invisible" do
    user = @developer.user

    assert_difference "Notification.count", 1 do
      InvisibleDeveloper.new(@developer).mark
    end

    assert_equal Notification.last.type, InvisiblizeDeveloperNotification.name
    assert_equal Notification.last.recipient, user
  end
end
