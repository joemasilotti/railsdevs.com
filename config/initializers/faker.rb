if Object.const_defined?(:Faker)
  # Ensure that all "random" seeded developers are always the same.
  Faker::Config.random = Random.new("railsdevs".bytes.sum)
end
