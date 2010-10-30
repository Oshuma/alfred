require 'rubygems' if RUBY_VERSION =~ /^1\.8/
require 'bundler/setup'

$LOAD_PATH.unshift File.dirname(__FILE__)

require 'lib/core_ext/module'

module Alfred
  VERSION = '0.4.1'

  class CommandError < StandardError; end

  autoload :App,     'alfred/app'
  autoload :Client,  'alfred/client'
  autoload :Command, 'alfred/command'

  CONFIG = ENV['ALFRED_CONFIG'] || File.expand_path("#{File.dirname(__FILE__)}/../config/alfred.yml")

  # Returns the configuration stored in <tt>./config/alfred.yml</tt>.
  def self.config
    raise "Alfred config not found: #{CONFIG}" unless File.exists?(CONFIG)
    @@config ||= ( YAML.load_file(CONFIG) || {} )
    @@config
  end
end
