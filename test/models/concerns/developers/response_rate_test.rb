require "test_helper"

module Developers
  class ResponseRateTest < ActiveSupport::TestCase
    test "returns :null for developer without conversations" do
      developer = developers(:one)
      assert_equal :null, developer.response_rate
    end

    test "returns :null for 0.89 response rate" do
      mock = Minitest::Mock.new
      def mock.replied_rate = 0.89

      Stats::Conversation.stub :new, mock do
        developer = developers(:one)
        assert_equal :null, developer.response_rate
      end
    end

    test "returns :good for 0.9 response rate" do
      mock = Minitest::Mock.new
      def mock.replied_rate = 0.9

      Stats::Conversation.stub :new, mock do
        developer = developers(:one)
        assert_equal :good, developer.response_rate
      end
    end

    test "returns :good for 0.99 response rate" do
      mock = Minitest::Mock.new
      def mock.replied_rate = 0.99

      Stats::Conversation.stub :new, mock do
        developer = developers(:one)
        assert_equal :good, developer.response_rate
      end
    end

    test "returns :perfect for 1.0 response rate" do
      mock = Minitest::Mock.new
      def mock.replied_rate = 1.0

      Stats::Conversation.stub :new, mock do
        developer = developers(:one)
        assert_equal :perfect, developer.response_rate
      end
    end
  end
end
