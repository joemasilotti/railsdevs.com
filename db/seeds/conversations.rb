# Core developer
developer = User.find_by(email: "developer@example.com").developer
business = User.find_by(email: "business@example.com").business
conversation = Conversation.find_or_create_by!(developer:, business:)
SeedsHelper.create_message!(conversation:, sender: business, body: "Your XP looks perfect.", cold_message: true)
SeedsHelper.create_message!(conversation:, sender: developer, body: "Let's chat over Zoom.")

# Potential hire
developer = User.find_by(email: "hired@example.com").developer
business = User.find_by(email: "business@example.com").business
conversation = Conversation.find_or_create_by!(developer:, business:)
SeedsHelper.create_message!(conversation:, sender: business, body: "Let's work together!", cold_message: true)
SeedsHelper.create_message!(conversation:, sender: developer, body: "I'd love to, let's do it.")

developer = User.find_by(email: "hired@example.com").developer
business = User.find_by(email: "part-time@example.com").business
conversation = Conversation.find_or_create_by!(developer:, business:)
SeedsHelper.create_message!(conversation:, sender: business, body: "Looking for freelance work?", cold_message: true)

# Populate response rate for developers
developers = Developer.joins(:conversations).distinct
developers.each { |d| UpdateDeveloperResponseRateJob.perform_now(d.id) }
