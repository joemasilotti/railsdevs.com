class DeviseFailureApp < Devise::FailureApp
  include Turbo::Native::Navigation

  def respond
    if request_format == :turbo_stream
      redirect
    elsif turbo_native_app?
      http_auth
    else
      super
    end
  end
end
