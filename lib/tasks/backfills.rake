desc "These tasks are meant to be run once then removed"
namespace :backfills do
  desc "Anonymize developer and business avatar filenames"
  task anonymize_avatar_filenames: :environment do
    Developer.joins(:avatar_attachment).with_attached_avatar.find_each do |developer|
      filename = "avatar#{developer.avatar.filename.extension_with_delimiter}"
      developer.avatar.blob.update!(filename:)
    end

    Business.joins(:avatar_attachment).with_attached_avatar.find_each do |developer|
      filename = "avatar#{developer.avatar.filename.extension_with_delimiter}"
      developer.avatar.blob.update!(filename:)
    end
  end
end
