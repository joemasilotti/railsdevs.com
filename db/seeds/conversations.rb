developer = User.find_by(email: "developer@example.com").developer
business = User.find_by(email: "business@example.com").business

conversation = Conversation.find_or_create_by!(developer:, business:)
Message.find_or_create_by!(conversation:, sender: business, body: "Let's work together!")
Message.find_or_create_by!(conversation:, sender: developer, body: "I'd love to, let's do it.")
