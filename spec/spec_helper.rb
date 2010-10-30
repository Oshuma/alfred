require 'rubygems' if RUBY_VERSION =~ /^1\.8/
require 'rspec'
require 'rack/test'

require "#{File.dirname(__FILE__)}/../lib/alfred"

module Rack::Test::Methods
  def app
    @app ||= Alfred::App.new
  end
end

RSpec.configure do |config|
  include Alfred
end
