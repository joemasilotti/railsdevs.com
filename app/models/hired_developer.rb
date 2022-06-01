HiredDeveloper = Struct.new(:title, :img, :description, keyword_init: true) do
  def self.all
    YAML.load_file(yaml_file)
      .map { |h| HiredDeveloper.new(h) }
  end

  def self.yaml_file
    File.join(Rails.root, "app", "data", "hired_developers.yml")
  end
end
