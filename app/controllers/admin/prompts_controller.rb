module Admin
  class PromptsController < ApplicationController
    def index
      @prompts = Admin::Prompt.all
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
