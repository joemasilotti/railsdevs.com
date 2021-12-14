class RolesController < ApplicationController
  def new
    redirect_to new_developer_path unless Feature.enabled?(:messaging)
  end
end
