require 'sinatra/base'
require 'json'

module Alfred
  class App < Sinatra::Base

    set :root, File.join(Dir.pwd, 'app')
    set :views, File.join(settings.root, 'views')

    set :public_folder, File.expand_path("#{settings.root}/../public")
    enable :static

    configure do
      Alfred.configure!(File.join(Dir.pwd, 'config/alfred.yml'))

      command_file = File.join(Dir.pwd, 'config/commands.yml')
      Alfred::Command.load_yaml!(command_file)
    end

    helpers do
      include Alfred::AppHelpers
      include Rack::Utils

      alias_method :h, :escape_html
    end

    before do
      @hostname = %x[hostname]
      @commands = Alfred::Command.all
    end

    # GET /
    # GET /commands
    [ '/', '/commands' ].each do |root_path|
      get root_path do
        ensure_web_enabled!
        erb(:index)
      end
    end

    # GET /c/:id
    # GET /command/:id
    [ '/command/:id', '/c/:id' ].each do |command_path|
      get command_path do
        ensure_web_enabled!
        @command = Alfred::Command.find(params[:id])
        erb(:command)
      end
    end

    # API: Authenticate
    # GET: /api/authenticate.json
    get '/api/authenticate.json' do
      ensure_api_enabled!
      headers 'Content-Type' => 'application/json'
      status 200 # OK
    end

    # API: Commands
    # GET: /api/commands.json
    get '/api/commands.json' do
      ensure_api_enabled!
      headers 'Content-Type' => 'application/json'
      @commands.to_json
    end
  end
end
