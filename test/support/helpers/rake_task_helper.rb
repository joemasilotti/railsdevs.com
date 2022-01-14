require "rake"

module RakeTaskHelper
  extend ActiveSupport::Concern

  included do
    # Checking if they are already loaded ensures we don't double load with test parallelization.
    def load_rake_tasks_once
      Railsdevs::Application.load_tasks if Rake::Task.tasks.empty?
    end
  end
end
