require 'sinatra/base'

module Alfred
  class App < Sinatra::Base

    set :root, File.join(Dir.pwd, 'app')
    set :views, File.join(settings.root, 'views')

    set :public_folder, File.expand_path("#{settings.root}/../public")
    enable :static

    configure do
      command_file = File.expand_path(File.join(Dir.pwd, 'config/commands.yml'))
      Alfred::Command.load_yaml!(command_file)
    end

    helpers do
      include Rack::Utils
      alias_method :h, :escape_html
    end

    get '/' do
      @commands = Alfred::Command.all
      erb(:index)
    end

    get '/commands' do
      @commands = Alfred::Command.all
      erb(:commands)
    end

    [ '/command/:id', '/c/:id' ].each do |command_path|
      get command_path do
        @command = Alfred::Command.find(params[:id])
        erb(:command)
      end
    end

  end
end
