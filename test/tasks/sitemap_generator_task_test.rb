require "test_helper"
require "rake"
Rails.application.load_tasks

class SitemapGeneratorTaskTest < ActiveSupport::TestCase
  test "sitemap is generated without any errors" do
    # disable sitemap generator outputs https://github.com/kjvarga/sitemap_generator/issues/332
    Rake::FileUtilsExt.verbose(false)
    Rake::Task["sitemap:refresh:no_ping"].invoke
  end
end
