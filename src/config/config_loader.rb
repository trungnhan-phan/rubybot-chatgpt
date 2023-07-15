require 'json'

module ConfigLoader
    CONFIG_FILE = File.expand_path('../config/config.json', __dir__).freeze
    @config = nil

  def self.load_config
    return @config if @config

    config_file = File.read(CONFIG_FILE)
    @config = JSON.parse(config_file)
  end

  def self.method_missing(method_name, *args, &block)
    config = load_config
    if config.key?(method_name.to_s)
      config[method_name.to_s]
    else
      super
    end
  end

  def self.respond_to_missing?(method_name, include_private = false)
    config = load_config
    config.key?(method_name.to_s) || super
  end
end