class HomeController < ApplicationController
  def show
    @developers = Developer.available.most_recently_added.with_attached_avatar.limit(10)
  end
end
