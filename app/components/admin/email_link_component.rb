module Admin
  class EmailLinkComponent < ApplicationComponent
    private attr_reader :email

    def initialize(email)
      @email = email
    end

    def call
      link_to email, "mailto:#{email}", class: "hover:underline"
    end
  end
end
