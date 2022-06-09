class ApplicationMailbox < ActionMailbox::Base
  routing(/^message-/ => :messages)
end
