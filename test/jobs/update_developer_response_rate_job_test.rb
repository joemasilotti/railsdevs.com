require "test_helper"

class UpdateDeveloperResponseRateJobTest < ActiveJob::TestCase
  setup do
    @developer = developers(:one)
  end

  test "should update developer response rate" do
    {
      0.79 => 70,
      0.80 => 80,
      0.81 => 80,
      0.89 => 80,
      0.90 => 90,
      0.91 => 90,
      0.99 => 90,
      1.00 => 100
    }.each do |replied_rate, expected_response_rate|
      mock = Minitest::Mock.new
      mock.expect :replied_rate, replied_rate

      Stats::Conversation.stub :new, mock do
        UpdateDeveloperResponseRateJob.perform_now(@developer)
        assert_equal expected_response_rate, @developer.reload.response_rate
      end
      assert_mock mock
    end
  end
end
