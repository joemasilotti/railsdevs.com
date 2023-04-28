# frozen_string_literal: true

require "test_helper"

class OfferTest < ActiveSupport::TestCase
  test "only one proposed or accepted offer is allowed for conversation at time" do
    conversation = conversations(:one)
    conversation.update!(offers: [offers(:one)])

    assert_raises ActiveRecord::RecordInvalid do
      Offer.create!(conversation:, start_date: Time.zone.today,
        pay_rate_value: 50, pay_rate_time_unit: "hour", state: "proposed")
    end

    assert_raises ActiveRecord::RecordInvalid do
      Offer.create!(conversation:, start_date: Time.zone.today,
        pay_rate_value: 50, pay_rate_time_unit: "hour", state: "accepted")
    end

    assert_instance_of(
      Offer,
      Offer.create!(conversation:, start_date: Time.zone.today,
        pay_rate_value: 50, pay_rate_time_unit: "hour", state: "declined")
    )
  end

  test "#deleted_sender? returns true when there's no business assigned to offer's conversation" do
    offer = offers(:one)

    assert_not offer.deleted_sender?

    offer.conversation.business.destroy
    offer.reload

    assert offer.deleted_sender?
  end

  test "#comment? returns true when offer's comment is nil" do
    offer = offers(:one)

    assert offer.comment?

    offer.comment = nil

    assert_not offer.comment?
  end

  test "#pay_rate_time_unit_key returns 'hour' when pay_rate_time_unit is 0" do
    assert_equal Offer.new(pay_rate_time_unit: 0).pay_rate_time_unit_key, "hour"
  end

  test "#pay_rate_time_unit_key returns 'day' when pay_rate_time_unit is 1" do
    assert_equal Offer.new(pay_rate_time_unit: 1).pay_rate_time_unit_key, "day"
  end

  test "#pay_rate_time_unit_key returns 'year' when pay_rate_time_unit is 2" do
    assert_equal Offer.new(pay_rate_time_unit: 2).pay_rate_time_unit_key, "year"
  end

  def create_notification(message, recipient)
    message.notifications_as_message.create!(recipient:,
      type: NewMessageNotification.name,
      params: {message:,
               conversation: message.conversation})
  end
end
