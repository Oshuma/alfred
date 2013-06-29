require 'ostruct'
require 'yaml'

require 'alfred/version'

module Alfred
  autoload :App, 'alfred/app'
  autoload :Command, 'alfred/command'

  class CommandError < StandardError; end

  def self.configure!(config_file)
    @@config = OpenStruct.new(::YAML.load_file(config_file))
  end

  def self.config
    @@config || OpenStruct.new
  end
end
