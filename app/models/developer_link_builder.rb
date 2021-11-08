class DeveloperLinkBuilder
  def initialize(options)
    @developer_id = options[:developer_id]
    @field = options[:field]
  end

  def url
    case @field.to_sym
    when :website
      website
    when :email
      "mailto:#{developer.user.email}"
    when :github
      "https://github.com/#{developer.github}"
    when :twitter
      "https://twitter.com/#{developer.twitter}"
    when :linkedin
      "https://www.linkedin.com/in/#{developer.linkedin}"
    end
  end

  private

  def developer
    @developer ||= Developer.find(@developer_id)
  end

  def website
    if developer.website.start_with?("https://", "http://")
      developer.website
    else
      "https://#{developer.website}"
    end
  end
end
