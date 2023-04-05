require "test_helper"

module Developers
  class CardComponentTest < ViewComponent::TestCase
    setup do
      @developer = developers(:one)
    end

    test "should render hero" do
      render_inline(CardComponent.new(developer: @developer))

      assert_selector("h2", text: @developer.hero)
    end

    test "should render bio" do
      render_inline(CardComponent.new(developer: @developer))

      assert_selector("p", text: @developer.bio)
    end

    test "should render avatar" do
      @blob = active_storage_blobs(:lovelace)
      render_inline(CardComponent.new(developer: @developer))

      assert_selector("img[src$='#{@blob.filename}']")
    end

    test "should render search status" do
      render_inline(CardComponent.new(developer: @developer))

      assert_selector("span", text: "Actively looking")
    end

    test "renders the badge if featured" do
      @developer.feature!
      render_inline(CardComponent.new(developer: @developer))
      assert_text I18n.t("developers.badges_component.featured")
    end

    test "highlights the border if featured and the option is set" do
      render_inline(CardComponent.new(developer: @developer, highlight_featured: true))
      assert_no_selector "a.border-l-4.border-blue-400"

      @developer.feature!
      render_inline(CardComponent.new(developer: @developer, highlight_featured: false))
      assert_no_selector "a.border-l-4.border-blue-400"

      render_inline(CardComponent.new(developer: @developer, highlight_featured: true))
      assert_selector "a.border-l-4.border-blue-400"
    end

    test "renders recently added badge if developer is new in last 7 days" do
      @developer.update!(bio: "I am the first developer")
      render_inline(CardComponent.new(developer: @developer))
      assert_text I18n.t("developers.badges_component.recently_added")
    end

    test "doesn't render recently added badge if developer was added more than 7 days ago" do
      @developer.update!(created_at: 2.weeks.ago)
      render_inline(CardComponent.new(developer: @developer))
      assert_no_text I18n.t("developers.card_component.recently_added")
    end

    test "renders source_contributor badge if developer is a source contributor" do
      @developer.source_contributor = true
      render_inline(CardComponent.new(developer: @developer))
      assert_text I18n.t("developers.badges_component.source_contributor")
    end

    test "doesn't render source_contributor badge if developer isn't a source contributor" do
      @developer.source_contributor = false
      render_inline(CardComponent.new(developer: @developer))
      assert_no_text I18n.t("developers.badges_component.source_contributor")
    end
  end
end
