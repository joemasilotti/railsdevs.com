class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    return root_path unless resource.developer

    developer_path resource.developer
  end

  def after_sign_out_path_for(resource)
    request.referer || root_path
  end
end
