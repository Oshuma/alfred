require 'alfred/version'

module Alfred
  autoload :App, 'alfred/app'
  autoload :Command, 'alfred/command'

  class CommandError < StandardError; end
end
