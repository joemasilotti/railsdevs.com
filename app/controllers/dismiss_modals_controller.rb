class DismissModalsController < ApplicationController
  def show
    @url = CGI.unescape(params[:url])
  end
end
