module Users
  class GithubUser
    attr_reader :client

    def initialize
      @client = Octokit::Client.new(access_token: Rails.application.credentials.github[:access_token])
    end

    def query_users
      usernames = Developer.where.not(github: nil).pluck(:github)

      users = usernames.map do |username|
        orgs = client.get("users/#{username}/orgs")
        user = client.user username
        {
          orgs: orgs.any?,
          company: user[:company].present?
        }
      rescue Octokit::NotFound
        next
      end

      users.compact!
      puts "Developer profiles\n"

      puts "Total: #{users.size}"
      puts "With GitHub organization(s): #{users.select { |user| user[:orgs] == true }.size}"
      puts "With company: #{users.select { |user| user[:company] == true }.size}"
      puts "With both: #{users.select { |user| user[:orgs] == true && user[:company] == true }.size}"
    end
  end
end
