developer = User.find_by(email: "developer@example.com").developer
business = User.find_by(email: "business@example.com").business
conversation = Conversation.find_or_create_by!(developer:, business:)
message = Message.find_or_create_by!(conversation:, sender: business, body: "Your XP looks perfect.")
Message.find_or_create_by!(conversation:, sender: developer, body: "Let's chat over Zoom.")

# MessageMailer#new_message
Notification.find_or_create_by!(type: NewMessageNotification.name, recipient: developer.user, params: {message:, conversation:})

# DeveloperMailer#welcome
Notification.find_or_create_by!(type: Developers::WelcomeNotification.name, recipient: developer.user, params: {developer:})

# DeveloperMailer#stale
stale_developer = User.find_by(email: "stale@example.com").developer
Notification.find_or_create_by!(type: Developers::ProfileReminderNotification.name, recipient: stale_developer.user, params: {developer: stale_developer})

# InvisiblizeMailer#to_developer
invisible_developer = User.find_by(email: "invisible@example.com").developer
Notification.find_or_create_by!(type: Developers::InvisiblizeNotification.name, recipient: invisible_developer.user, params: {developer: invisible_developer})

# InvisiblizeMailer#to_business
invisible_business = User.find_by(email: "invisible@example.com").business
Notification.find_or_create_by!(type: Businesses::InvisiblizeNotification.name, recipient: invisible_business.user, params: {business: invisible_business})

# AdminMailer#new_business
admin = User.find_by(email: "admin@example.com")
Notification.find_or_create_by!(type: Admin::NewBusinessNotification.name, recipient: admin, params: {business:})

# AdminMailer#new_conversation
Notification.find_or_create_by!(type: Admin::NewConversationNotification.name, recipient: admin, params: {message:, conversation:})

# AdminMailer#new_developer_profile
Notification.find_or_create_by!(type: Admin::NewDeveloperNotification.name, recipient: admin, params: {developer:})

# AdminMailer#potential_hire
developer = User.find_by(email: "hired@example.com").developer
Notification.find_or_create_by!(type: Admin::PotentialHireNotification.name, recipient: admin, params: {developer:})
