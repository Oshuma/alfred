require 'sinatra/base'

module Alfred
  class App < Sinatra::Base

    set :root, File.join(Dir.pwd, 'app')
    set :views, File.join(settings.root, 'views')

    set :public_folder, File.expand_path("#{settings.root}/../public")
    enable :static

    configure do
      command_file = File.expand_path(File.join(Dir.pwd, 'config/commands.yml'))
      Alfred::Command.from_yaml!(command_file)
    end

    helpers do
      include Rack::Utils
      alias_method :h, :escape_html
    end

    get '/' do
      @commands = Alfred::Command.all
      erb(:index)
    end

  end
end
