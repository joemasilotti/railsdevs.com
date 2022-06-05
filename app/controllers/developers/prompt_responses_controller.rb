module Developers
  class PromptResponsesController < ApplicationController
    before_action :authenticate_user!, only: %i[new create edit update destroy]

    def index
      @developer = ::Developer.find(params[:developer_id])
      @prompt_responses = @developer.prompt_responses.includes(:prompt)
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
        render "create"
      else
        @prompts = Admin::Prompt.active
        render "new", status: :unprocessable_entity
      end
    end

    def edit
      @prompt_response = PromptResponse.find(params[:id])
      authorize(@prompt_response)

      @prompts = Admin::Prompt.active
    end

    def update
      @prompt_response = PromptResponse.find(params[:id])
      authorize @prompt_response

      if @prompt_response.update(response_params)
        render "update"
      else
        @prompts = Admin::Prompt.active
        render "edit", status: :unprocessable_entity
      end
    end

    def destroy
      @prompt_response = PromptResponse.find(params[:id])
      authorize @prompt_response
      @prompt_response.destroy

      render 'destroy'
    end

    private

    def response_params
      params.require(:developers_prompt_response).permit(:prompt_id, :content)
    end
  end
end
