module Developers
  class Finder
    NON_ID_PATTERN = /\D+/

    attr_reader :developer

    def initialize(id:)
      @id = id.to_s
      @redirect = false
    end

    def call
      if use_hashid?
        if NON_ID_PATTERN.match?(@id)
          @developer = Developer.find_by_hashid!(@id)
        else
          find_by_id!
          @redirect = true
        end
      else
        find_by_id!
      end

      self
    end

    def should_redirect?
      @redirect
    end

    private

    def find_by_id!
      @developer = Developer.find(@id)
    end

    def use_hashid?
      Feature.enabled?(:obfuscate_developer_urls)
    end
  end
end
