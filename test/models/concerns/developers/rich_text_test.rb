require "test_helper"

class Developers::RichTextTest < ActiveSupport::TestCase
  test "parses bio correctly" do
    developer = developers(:one)
    bio = <<~MD
    # H1
    This is _underlined_
    `Inline code block`
    MD
    developer.update!(bio: bio)

    assert_match /\<h1\>H1\<\/h1\>/, developer.rich_text_bio
    assert_match "This is <u>underlined</u>", developer.rich_text_bio
    assert_match '<code>Inline code block</code>', developer.rich_text_bio
  end

  test "Disallows manually written HTML tags" do
    developer = developers(:one)
    bio = <<~MD
    <h1>Hello world</h1>
    MD
    developer.update!(bio: bio)

    assert_no_match /\<h1\>Hello world\<\/h1\>/, developer.rich_text_bio
    assert_match /\<p\>Hello world\<\/p\>/, developer.rich_text_bio
  end

  test "Ignores links" do
    developer = developers(:one)
    bio = <<~MD
    [Text](https://example.com)
    MD
    developer.update!(bio: bio)

    assert_match developer.rich_text_bio, ""
  end
end
