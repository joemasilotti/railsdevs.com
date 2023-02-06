require "test_helper"

module Developers
  class ResponseRateTest < ActiveSupport::TestCase
    test "returns 0 for developer without conversations" do
      developer = developers(:one)
      assert_equal 0, developer.response_rate
    end

    test "returns 80 for 0.89 response rate" do
      mock = Minitest::Mock.new
      def mock.replied_rate = 0.89

      Stats::Conversation.stub :new, mock do
        developer = developers(:one)
        assert_equal 80, developer.response_rate
      end
    end

    test "returns 90 for 0.9 response rate" do
      mock = Minitest::Mock.new
      def mock.replied_rate = 0.9

      Stats::Conversation.stub :new, mock do
        developer = developers(:one)
        assert_equal 90, developer.response_rate
      end
    end

    test "returns 90 for 0.99 response rate" do
      mock = Minitest::Mock.new
      def mock.replied_rate = 0.99

      Stats::Conversation.stub :new, mock do
        developer = developers(:one)
        assert_equal 90, developer.response_rate
      end
    end

    test "returns 100 for 1.0 response rate" do
      mock = Minitest::Mock.new
      def mock.replied_rate = 1.0

      Stats::Conversation.stub :new, mock do
        developer = developers(:one)
        assert_equal 100, developer.response_rate
      end
    end
  end
end
