desc "These tasks are meant to be run once then removed"
namespace :backfills do
  task touch_conversations: :environment do
    Message.group(:conversation).maximum(:created_at).each do |conversation, message_created_at|
      conversation.update!(updated_at: message_created_at)
    end
  end
end
