$LOAD_PATH.unshift File.dirname(__FILE__)

module Alfred
  VERSION = '0.2.1'

  class CommandError < StandardError; end

  autoload :App,     'alfred/app'
  autoload :Client,  'alfred/client'
  autoload :Command, 'alfred/command'
end
