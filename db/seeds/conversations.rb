developer = User.find_by(email: "developer@example.com").developer
business = User.find_by(email: "business@example.com").business

conversation = Conversation.create!(developer:, business:)
Message.create!(conversation:, sender: business, body: "Let's work together!")
Message.create!(conversation:, sender: developer, body: "I'd love to, let's do it.")
