class WebpController < ApplicationController
  def show
    @developer = Developer.joins(:avatar_attachment).first
  end
end
