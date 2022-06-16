module TurboNativeHelper
  def turbo_native_request!
    request.user_agent = "Turbo Native"
  end
end
