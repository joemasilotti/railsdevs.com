class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    developer_path resource
  end

  def after_sign_out_path_for(resource)
    request.referer || root_path
  end
end
