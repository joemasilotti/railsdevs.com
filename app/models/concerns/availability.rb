module Availability
  extend ActiveSupport::Concern

  included do
    enum availability_status: [:unspecified, :now, :in_future, :now_remote, :now_location, :in_future_remote, :in_future_location], _default: :unspecified, _prefix: :available

    after_initialize :derive_availability_status
  end

  def available?
    available_now? || available_now_remote? || available_now_location?
  end

  def available_future?
    available_in_future? || available_in_future_remote? || available_in_future_location?
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
      if location?
        :in_future_location
      elsif remote?
        :in_future_remote
      else
        :in_future
      end
    elsif location?
      :now_location
    elsif remote?
      :now_remote
    else
      :now
    end

    self.availability_status = status
  end
end
