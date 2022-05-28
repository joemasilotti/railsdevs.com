module Developers
  class PromptResponsesController < ApplicationController
    before_action :authenticate_user!, only: %i[new create edit update destroy]

    def index
      @developer = ::Developer.find(params[:developer_id])
      @prompt_responses = @developer.prompt_responses.includes(:prompts)
      authorize @developer, policy_class: Developers::PromptResponsePolicy
    end

    def new
      @developer = ::Developer.find(params[:developer_id])
      @prompt_response = @developer.prompt_responses.build
      authorize @prompt_response

      @prompts = Admin::Prompt.active
    end

    def create
      @developer = ::Developer.find(params[:developer_id])
      @prompt_response = @developer.prompt_responses.build(response_params)
      authorize @prompt_response

      if @prompt_response.save
        redirect_to developer_path(@developer), notice: "Response published to profile!"
      else
        render "new", status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def response_params
      params.require(:developers_prompt_response).permit(:prompt_id, :content)
    end
  end
end
