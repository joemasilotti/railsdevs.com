module Developers
  class PromptResponse < ApplicationRecord
    include Rails.application.routes.url_helpers

    belongs_to :prompt, class_name: "Admin::Prompt"
    belongs_to :developer

    validates :content, presence: true, length: {maximum: 280}
    validates :prompt_id, uniqueness: {scope: :developer_id}

    scope :active, -> { includes(:prompt).where(prompts: {active: true}) }

    def form_action
      persisted? ? prompt_response_path(id: self) : developer_prompt_responses_path(developer_id: developer)
    end
  end
end
