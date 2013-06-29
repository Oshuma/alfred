require 'rspec'
require 'rack/test'

# Specify the test config before loading Alfred.
ENV['ALFRED_CONFIG'] ||= File.expand_path("#{File.dirname(__FILE__)}/alfred.yml")

require 'alfred'

module Rack::Test::Methods
  def app
    @app ||= Alfred::App.new
  end
end

RSpec.configure do |config|
  include Alfred
end
