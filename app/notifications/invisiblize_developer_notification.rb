class InvisiblizeDeveloperNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "DeveloperMailer", method: :flagged

  param :developer

  def developer
    params[:developer]
  end
end
