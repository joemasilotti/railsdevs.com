# frozen_string_literal: true

require "test_helper"

module Developers
  class ResultsVisibilityComponentTest < ViewComponent::TestCase
    include DevelopersHelper

    setup do
      20.times do
        create_developer(hero: "Available", available_on: Date.today)
      end

      @query = DeveloperQuery.new(page: 2)
      @developer = @query.records.first
    end

    test "should hide results on page 2+ with a CTA for non-subscribers" do
      user = users(:business)

      render_inline(ResultsVisibilityComponent.new(query: @query, user:, paywalled: @developer)) do |component|
        component.results_set records: component.records
      end
      assert_text I18n.t("users.paywalled_component.title")

      render_inline(ResultsVisibilityComponent.new(query: @query, user: nil, paywalled: @developer)) do |component|
        component.results_set records: component.records
      end
      assert_text I18n.t("users.paywalled_component.title")

      render_inline(ResultsVisibilityComponent.new(query: @query, user: nil, paywalled: nil)) do |component|
        component.results_set records: component.records
      end
      assert_text I18n.t("users.paywalled_component.title")
    end

    test "should display results on page 2+ for subscribers" do
      user = users(:subscribed_business)

      render_inline(ResultsVisibilityComponent.new(query: @query, user:, paywalled: @developer)) do |component|
        component.results_set records: component.records
      end
      assert_no_text I18n.t("users.paywalled_component.title")
    end

    test "should display results on page 2+ for owners" do
      user = users(:developer)

      render_inline(ResultsVisibilityComponent.new(query: @query, user:, paywalled: @developer)) do |component|
        component.results_set records: component.records
      end
      assert_no_text I18n.t("users.paywalled_component.title")
    end

    test "should show small CTA if paywalled" do
      user = users(:business)

      render_inline(ResultsVisibilityComponent.new(query: @query, user:, paywalled: @developer, size: :small)) do |component|
        component.results_set records: component.records
      end
      assert_text I18n.t("users.paywalled_component.title")
      assert_no_text I18n.t("users.paywalled_component.description")
    end

    test "should show large CTA if paywalled" do
      user = users(:business)

      render_inline(ResultsVisibilityComponent.new(query: @query, user:, paywalled: @developer, size: :large)) do |component|
        component.results_set records: component.records
      end
      assert_text I18n.t("users.paywalled_component.title")
      assert_text I18n.t("users.paywalled_component.description")
    end
  end
end
