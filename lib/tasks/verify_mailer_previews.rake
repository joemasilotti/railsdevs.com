desc "Render each mailer preview to ensure no errors."
task verify_mailer_previews: :environment do
  mailer_previews = ActionMailer::Preview.all
  raise "No mailer previews!" unless mailer_previews.any?

  mailer_previews.each do |mailer|
    mailer.emails.each do |email|
      mailer.call(email)
    end
  end
end
