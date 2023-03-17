require "test_helper"

class InactiveEmailJobTest < ActiveJob::TestCase
  include NotificationsHelper

  class ExampleJob < ApplicationJob
    def perform
      raise Postmark::InactiveRecipientError.new
    end
  end

  test "discards job and doesn't retry on Postmark::InactiveRecipientError exception" do
    assert_nothing_raised do
      ExampleJob.perform_now
    end
  end
end
