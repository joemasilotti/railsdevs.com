class UsersController < Devise::RegistrationsController
  invisible_captcha only: :create
end
