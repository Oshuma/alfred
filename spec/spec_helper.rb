spec_deps = %w[
  spec
  rack/test
]
begin
  spec_deps.each { |lib| require lib }
rescue LoadError
  require 'rubygems'
  spec_deps.each { |lib| require lib }
end

require "#{File.dirname(__FILE__)}/../lib/alfred"

module Rack::Test::Methods
  def app
    @app ||= Alfred::App.new
  end
end

Spec::Runner.configure do |config|
end
