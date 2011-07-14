vidli_yml_config_path = File.join(File.expand_path(::Rails.root.to_s),'config','vidli_config.yml')
VidliConfig = ConfigurationManager.new_manager(Rails.env, vidli_yml_config_path)