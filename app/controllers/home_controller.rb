class HomeController < ApplicationController
  def show
    @developers = Developer.available.with_attached_avatar.limit(10)
  end
end
