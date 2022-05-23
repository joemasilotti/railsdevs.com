module Admin
  class PromptsController < ApplicationController
    def index
      @prompts = Admin::Prompt.all
    end

    def new
      @prompt = Admin::Prompt.new
    end

    def create
      @prompt = Admin::Prompt.new(prompt_params)

      if @prompt.save
        render "create"
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

    def prompt_params
      params.require(:admin_prompt).permit(:active, :name)
    end
  end
end
