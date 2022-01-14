require "test_helper"

class SitemapGeneratorTaskTest < ActiveSupport::TestCase
  include RakeTaskHelper

  test "sitemap is generated without any errors" do
    load_rake_tasks_once
    disable_sitemap_generator_output
    Rake::Task["sitemap:create"].invoke
  end

  def disable_sitemap_generator_output
    Rake::FileUtilsExt.verbose(false)
  end
end
