class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    if resource.developer.present?
      developer_path resource.developer
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    request.referer || root_path
  end
end
