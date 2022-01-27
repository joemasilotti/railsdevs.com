namespace :messages do
  desc "Migrate message bodies to save formatted HTML in the database."
  task migrate_body_html: :environment do
    Message.where(body_html: nil).find_each do |message|
      message.body = message.body
      message.save!
    end
  end
end
