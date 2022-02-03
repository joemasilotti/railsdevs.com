module Availability
  extend ActiveSupport::Concern

  included do
    enum availability_status: [:unspecified, :now, :in_future], _default: :unspecified, _prefix: :available

    after_initialize :derive_availability_status
  end

  def available_in_days=(days)
    super(days&.clamp(0..))
    derive_availability_status
  end

  def available_in_days
    super&.days
  end

  def available_on
    super || (available_in_days.present? ? Date.current + available_in_days : nil)
  end

  def available_on=(date)
    super(date)
    derive_availability_status
  end

  private

  def derive_availability_status
    status = if available_on.nil?
      :unspecified
    elsif available_on.future?
      :in_future
    else
      :now
    end

    self.availability_status = status
  end
end
