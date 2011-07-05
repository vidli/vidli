class ConfigurationManager
  # Expects the environment to load.
  # Second argument is path to a YAML file (defaults to RAILS_ROOT/config/configuration_manager.yml)
  # Use Rails.root instead of RAILS_ROOT if Rails 3.
  #
  def self.new_manager(environment=nil, yaml_file=nil)
    environment ||= begin Rails.env; rescue; RAILS_ENV end
    yaml_file   ||= File.expand_path(File.join(begin Rails.root; rescue; RAILS_ROOT end, '/config/configuration_manager.yml'))
    if File.exist?(yaml_file)
      ConfigurationManagerHash.new_from_hash(YAML.load(ERB.new(File.read(yaml_file)).result)[environment])
    else
      ConfigurationManagerHash.new
    end
  end
end