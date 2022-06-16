module DeviceFormat
  extend ActiveSupport::Concern

  included do
    before_action :set_variant_for_device
  end

  private

  def set_variant_for_device
    request.variant = :native if turbo_native_app?
  end
end
