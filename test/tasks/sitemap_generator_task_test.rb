require "test_helper"
require "rake"

class SitemapGeneratorTaskTest < ActiveSupport::TestCase
  Rails.application.load_tasks

  test "sitemap is generated without any errors" do
    disable_sitemap_generator_output
    Rake::Task["sitemap:create"].invoke
  end

  def disable_sitemap_generator_output
    Rake::FileUtilsExt.verbose(false)
  end
end
