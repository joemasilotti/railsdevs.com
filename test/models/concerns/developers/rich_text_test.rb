require "test_helper"

class Developers::RichTextTest < ActiveSupport::TestCase
  test "#rich_text_bio parses bio correctly" do
    developer = developers(:one)
    bio = <<~MD
      # H1
      This is _underlined_
      `Inline code block`
    MD
    developer.update!(bio:)

    assert_match(/<h1>H1<\/h1>/, developer.rich_text_bio)
    assert_match "This is <u>underlined</u>", developer.rich_text_bio
    assert_match "<code>Inline code block</code>", developer.rich_text_bio
  end

  test "#rich_text_bio disallows manually written HTML tags" do
    developer = developers(:one)
    bio = <<~MD
      <h1>Hello world</h1>
    MD
    developer.update!(bio:)

    assert_no_match(/<h1>Hello world<\/h1>/, developer.rich_text_bio)
    assert_match(/<p>Hello world<\/p>/, developer.rich_text_bio)
  end

  test "#rich_text_bio ignores links" do
    developer = developers(:one)
    bio = <<~MD
      [Text](https://example.com)
    MD
    developer.update!(bio:)

    assert_equal developer.rich_text_bio, "<p>[Text](https://example.com)</p>"
  end

  test "#rich_text_bio ignores images" do
    developer = developers(:one)
    bio = <<~MD
      ![Image](https://example.com)
    MD
    developer.update!(bio:)

    assert_equal developer.rich_text_bio, "<p>![Image](https://example.com)</p>"
  end

  test "#plain_text_bio strips to plaintext" do
    developer = developers(:one)
    bio = <<~MD
      **hi** _bye_
    MD
    developer.update!(bio:)

    assert_equal developer.plain_text_bio, "hi bye"
  end
end
