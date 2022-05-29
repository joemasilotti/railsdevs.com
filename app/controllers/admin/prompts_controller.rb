module Admin
  class PromptsController < ApplicationController
    include ActionView::RecordIdentifier

    def index
      @prompts = Admin::Prompt.all.order(created_at: :asc)
    end

    def new
      @prompt = Admin::Prompt.new
    end

    def create
      @prompt = Admin::Prompt.new(new_prompt_params)

      if @prompt.save
        render "create"
      else
        render "new", status: :unprocessable_entity
      end
    end

    def update
      @prompt = Admin::Prompt.find(params[:id])

      if @prompt.update(edit_prompt_params)
        head :ok
      else
        head :bad_request
      end
    end

    def destroy
      @prompt = Admin::Prompt.find(params[:id])
      @prompt.destroy

      render turbo_stream: turbo_stream.remove(dom_id(@prompt))
    end

    private

    def new_prompt_params
      params.require(:admin_prompt).permit(:active, :name)
    end

    def edit_prompt_params
      params.require(:admin_prompt).permit(:active)
    end
  end
end
