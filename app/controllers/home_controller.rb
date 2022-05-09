class HomeController < ApplicationController
  def show
    @developers = Developer
      .visible
      .includes(:role_type).with_attached_avatar
      .available.newest_first
      .limit(10)
    @hired_developers = YAML.load_file(hired_developers_yaml)
  end

  private

  def hired_developers_yaml
    File.join(Rails.root, "app", "data", "hired_developers.yml")
  end
end
