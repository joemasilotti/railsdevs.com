class ApplicationMailbox < ActionMailbox::Base
  # TODO: Be more specific here for futre inbound emails.
  routing all: :messages
end
