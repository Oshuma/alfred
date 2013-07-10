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
      include Rack::Utils
      alias_method :h, :escape_html

      def check_auth_token!
        return unless Alfred.config.auth_token

        auth_token = request.env['HTTP_X_AUTH_TOKEN']

        error 401 if auth_token.nil?
        error 401 unless auth_token == Alfred.config.auth_token
      end

      def check_basic_auth!
        return unless Alfred.config.username

        self.class.use Rack::Auth::Basic, "Restricted Area" do |username, password|
          (username == Alfred.config.username) && (password == Alfred.config.password)
        end
      end
    end

    before do
      @hostname = %x[hostname]
      @commands = Alfred::Command.all
    end

    # GET /
    # GET /commands
    [ '/', '/commands' ].each do |root_path|
      get root_path do
        check_basic_auth!
        erb(:index)
      end
    end

    # GET /c/:id
    # GET /command/:id
    [ '/command/:id', '/c/:id' ].each do |command_path|
      get command_path do
        check_basic_auth!
        @command = Alfred::Command.find(params[:id])
        erb(:command)
      end
    end

    # API: Authenticate
    # GET: /api/authenticate.json
    get '/api/authenticate.json' do
      check_auth_token!
      headers 'Content-Type' => 'application/json'
      status 202 # Accepted
    end

    # API: Commands
    # GET: /api/commands.json
    get '/api/commands.json' do
      check_auth_token!
      headers 'Content-Type' => 'application/json'
      @commands.to_json
    end
  end
end
