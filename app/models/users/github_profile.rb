module Users
  class GithubProfile
    def initialize
      @client = Octokit::Client.new(access_token: Rails.application.credentials.github[:access_token])
    end

    def create(developer)
      @username = developer.github
      query_github

      developer.create_github_profile! organizations: orgs, company: company
    rescue Octokit::NotFound
    end

    private

    attr_reader :client, :username, :company, :orgs

    def query_github
      @orgs = client.get("users/#{username}/orgs").to_a.map { |org| org[:id] }
      @company = client.user(username).dig(:company)
    end
  end
end
