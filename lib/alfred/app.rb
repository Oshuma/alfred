require 'sinatra/base'
require 'erb'

module Alfred
  class App < Sinatra::Base

    set :root, "#{File.dirname(__FILE__)}/../../app"
    enable :static

    before do
      @hostname = Alfred::Command.exec('hostname')
    end

    get '/' do
      command_file = File.dirname(__FILE__) + '/../../config/commands.yml'
      @commands = Alfred::Command.from_yaml(command_file)
      # @commands = [
      #   Alfred::Command.new('Disk Usage', 'df -h'),
      #   # Alfred::Command.new('Memory', 'free'),
      #   Alfred::Command.new('Users', 'w'),
      #   Alfred::Command.new('Uptime', 'uptime')
      # ]
      erb :index
    end

  end
end
