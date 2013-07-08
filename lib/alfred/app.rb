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
    end

    before do
      if Alfred.config.auth_token
        auth_token = request.env['HTTP_AUTHORIZATION']

        halt 401 if auth_token.nil?
        halt 401 unless auth_token == Alfred.config.auth_token
      elsif Alfred.config.username
        self.class.use Rack::Auth::Basic, "Restricted Area" do |username, password|
          (username == Alfred.config.username) && (password == Alfred.config.password)
        end
      end

      @hostname = %x[hostname]
      @commands = Alfred::Command.all
    end

    [ '/', '/commands' ].each do |root_path|
      get root_path do
        erb(:index)
      end
    end

    [ '/command/:id', '/c/:id' ].each do |command_path|
      get command_path do
        @command = Alfred::Command.find(params[:id])
        erb(:command)
      end
    end

    # API: Authenticate
    # This exists to give the client a positive result, since Unauthorized
    # will be throw in the `before` block if authentication fails.
    get '/api/authenticate.json' do
      status 202 # Accepted
    end

    # API: Commands
    get '/api/commands.json' do
      headers 'Content-Type' => 'application/json'
      @commands.to_json
    end
  end
end
