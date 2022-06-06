require "test_helper"

module Messages
  class ReadAtComponentTest < ViewComponent::TestCase
    setup do
      @message = messages(:from_developer)
      @message.notifications_as_message.last.mark_as_read!
    end

    test "should show read at timestamp if last message in conversation" do
      @message.stub :last_message_in_conversation?, true do
        render_inline Messages::ReadAtComponent.new(message: @message)
      end

      assert_text "Read at #{@message.read_at}"
    end

    test "should not show read at timestamp if last message in conversation and no read_at" do
      @message.stub :last_message_in_conversation?, true do
        @message.stub :read_at, nil do
          render_inline Messages::ReadAtComponent.new(message: @message)
        end
      end

      assert_no_text "Read at #{@message.read_at}"
    end

    test "should not show read at timestamp if not last message in conversation" do
      @message.stub :last_message_in_conversation?, false do
        render_inline Messages::ReadAtComponent.new(message: @message)
      end

      assert_no_text "Read at #{@message.read_at}"
    end
  end
end
