class InvisiblizeDeveloperNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "DeveloperMailer", method: :invisiblize

  param :developer

  def developer
    params[:developer]
  end
end
