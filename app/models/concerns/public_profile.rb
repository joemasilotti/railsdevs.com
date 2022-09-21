module PublicProfile

  extend ActiveSupport::Concern
  
  def share_url(url)
    update_public_profile_key if self.public_profile_key.blank?    
    share_url = form_url(url, self.public_profile_key)
  end

  private

    def form_url(url, query_param)
      parsed = URI.parse(url)
      query = if parsed.query
              CGI.parse(parsed.query)
            else
              {}
            end

      query['key'] = query_param

      parsed.query = URI.encode_www_form(query)
      parsed.to_s
    end

    def update_public_profile_key
      update!(public_profile_key: generate_token)
    end

    def generate_token
      loop do
        public_key = SecureRandom.hex(10)
        break public_key unless self.class.find_by(public_profile_key: public_key)
      end
    end
end