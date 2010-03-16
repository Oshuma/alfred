$LOAD_PATH.unshift File.dirname(__FILE__)

module Alfred
  VERSION = '0.2.0'

  autoload :App,     'alfred/app'
  autoload :Command, 'alfred/command'
end
