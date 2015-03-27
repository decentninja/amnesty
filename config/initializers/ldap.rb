config_file = File.join(Rails.root, 'config', 'ldap.yml')
settings = YAML.load(File.read config_file)[Rails.env]
Rails.logger.debug settings.to_s
LDAPLookup::Importable.settings = settings
