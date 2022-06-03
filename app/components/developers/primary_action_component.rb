module Developers
  class PrimaryActionComponent < ApplicationComponent
    def initialize(user:, developer:)
      @user = user
      @developer = developer
    end

    def owner?
      @user&.developer == @developer
    end
  end
end
