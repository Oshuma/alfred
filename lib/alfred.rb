$LOAD_PATH.unshift File.dirname(__FILE__)

require 'lib/core_ext/module'

module Alfred
  VERSION = '0.3.1'

  class CommandError < StandardError; end

  autoload :App,     'alfred/app'
  autoload :Client,  'alfred/client'
  autoload :Command, 'alfred/command'
end
