developer = User.find_by(email: "developer@example.com").accounts.first.developer
business = User.find_by(email: "business@example.com").accounts.first.business

conversation = Conversation.create!(developer:, business:)
Message.create!(conversation:, sender: business, body: "Let's work together!")
Message.create!(conversation:, sender: developer, body: "I'd love to, let's do it.")
