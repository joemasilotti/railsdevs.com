module JSONFixtureHelper
  def json_fixture(relative_path)
    path = Rails.root.join("test", "fixtures", relative_path)
    fixture = File.read(path)
    JSON.parse(fixture)
  end
end
