# frozen_string_literal: true

module Developers
  class ResultsVisibilityComponent < ApplicationComponent
    renders_one :results_set, ->(records:) do
      CardComponent.with_collection(records)
    end

    def initialize(query:, user:, paywalled: nil, size: :large, title: nil, description: nil)
      @query = query
      @user = user
      @paywalled = paywalled
      @size = size
      @title = title
      @description = description
    end

    def render_content?
      pagy.page > 1 ? customer? || owner? : true
    end

    def small?
      @size == :small
    end

    def large?
      @size == :large
    end

    def title
      @title || t("users.paywalled_component.title")
    end

    def description
      @description || t("users.paywalled_component.description")
    end

    def pagy
      @query.pagy
    end

    def records
      @query.records
    end

    private

    def customer?
      Businesses::Permission.new(@user&.subscriptions).active_subscription?
    end

    def owner?
      @paywalled&.user == @user && @user.present?
    end
  end
end
