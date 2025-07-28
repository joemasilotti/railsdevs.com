namespace :shut_down do
  desc "Send shut down email to all businesses"
  task businesses: :environment do
    puts "Sending shutdown email to all businesses..."

    Business.includes(:user).find_each.with_index do |business, index|
      BusinessMailer.with(business:).shut_down.deliver_later
      puts "Queued email ##{index + 1} to #{business.user.email}"
    end

    puts "All emails have been queued!"
  end

  desc "Send shut down email to all developers"
  task developers: :environment do
    puts "Sending shutdown email to all developers..."

    Developer.includes(:user).find_each.with_index do |developer, index|
      DeveloperMailer.with(developer:).shut_down.deliver_later
      puts "Queued email ##{index + 1} to #{developer.user.email}"
    end

    puts "All emails have been queued!"
  end
end
