require 'sinatra/base'
require 'erb'

module Alfred
  class App < Sinatra::Base

    set :root, "#{File.dirname(__FILE__)}/../../app"
    enable :static

    before do
      @hostname = Alfred::Command.exec('hostname')
      @command_file = File.dirname(__FILE__) + '/../../config/commands.yml'
    end

    get '/' do
      @commands = Alfred::Command.from_yaml(@command_file)
      erb :index
    end

  end
end
