require "test_helper"
require "rake"
Rails.application.load_tasks

class SitemapGeneratorTaskTest < ActiveSupport::TestCase
  test "sitemap is generated without any errors" do
    Rake::Task["sitemap:refresh:no_ping"].invoke
  end
end
