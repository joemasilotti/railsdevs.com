desc "These tasks are meant to be run once then removed"
namespace :backfills do
  desc "Generate avatar variants for developers and businesses"
  task process_avatar_variants: :environment do
    ActiveStorage::Attachment.where(name: "avatar").find_each do |attachment|
      attachment.variant(:thumb).processed
      attachment.variant(:medium).processed
    end
  end
end
