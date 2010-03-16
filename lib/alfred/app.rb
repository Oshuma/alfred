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

    helpers do
      include Rack::Utils
      alias_method :h, :escape_html

      def anchor_name(string)
        link = string.gsub(/\s/, '_').downcase
        link
      end
    end

    # Text representation (for curling).
    get '/', :agent => /^curl\/([\d\.]+)/ do
      @commands = Alfred::Command.from_yaml(@command_file)
      erb :index_text, :layout => false
    end

    get '/' do
      @commands = Alfred::Command.from_yaml(@command_file)
      erb :index
    end

  end
end
