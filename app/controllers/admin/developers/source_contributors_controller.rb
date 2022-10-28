module Admin
  module Developers
    class SourceContributorsController < ApplicationController
      def create
        Developer.find(params[:developer_id]).update(source_contributor: true)
        redirect_back_or_to root_path, allow_other_host: false
      end

      def destroy
        Developer.find(params[:developer_id]).update(source_contributor: false)
        redirect_back_or_to root_path, allow_other_host: false
      end
    end
  end
end
