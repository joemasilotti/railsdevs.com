module Developers
  class PromptResponsesController < ApplicationController
    before_action :authenticate_user!, only: %i[new create edit update destroy]

    def index
      @developer = ::Developer.find(params[:developer_id])
      @prompt_responses = @developer.prompt_responses.includes(:prompts)
    end

    def new
    end

    def create
    end

    def edit
    end

    def update
    end

    def destroy
    end
  end
end
