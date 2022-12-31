class HomeController < ApplicationController
  def show
    @developers = Developer.where(id: developer_ids)
  end

  private

  def developer_ids
    Rails.cache.fetch("home_show/developer_ids", expires_in: 1.day) do
      Developer
        .visible
        .includes(:role_type).with_attached_avatar
        .actively_looking.available
        .order("RANDOM()")
        .limit(10)
        .pluck(:id)
    end
  end
end
