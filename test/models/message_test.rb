require "test_helper"

class MessageTest < ActiveSupport::TestCase
  test "user is sender if they are the associated developer" do
    user = users(:prospect_developer)
    assert messages(:from_developer).sender?(user)
    refute messages(:from_business).sender?(user)
  end

  test "user is sender if they are the associated business" do
    user = users(:subscribed_business)
    assert messages(:from_business).sender?(user)
    refute messages(:from_developer).sender?(user)
  end

  test "user is not the sender if they are neither the associated developer nor business" do
    user = users(:empty)
    refute messages(:from_developer).sender?(user)
  end

  test "body_html is filled with rendered html version of body" do
    message = Message.new(body: "Check out https://railsdevs.com/!")

    assert_equal '<p>Check out <a href="https://railsdevs.com/" target="_blank">https://railsdevs.com/</a>!</p>', message.body_html
  end
end
