path = Rails.root.join("config", "wordstadium_database.yml")
if File.exist?(path)
  config    = YAML::load(ERB.new(File.read(path)).result)
  WORDSTADIUM_DB = config[Rails.env]
end
