namespace :css do
  desc "Build your CSS bundle for the redesign"
  task :redesign do
    unless system "yarn install && yarn build:redesign"
      raise "Command css:redesign failed, ensure yarn is installed and `yarn build:redesign` runs without errors"
    end
  end
end

if Rake::Task.task_defined?("assets:precompile")
  Rake::Task["assets:precompile"].enhance(["css:redesign"])
end
