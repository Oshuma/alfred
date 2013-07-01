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
      @hostname = %x[hostname]

      if Alfred.config.auth_token
        auth_token = request.env['HTTP_X_AUTH_TOKEN']

        halt 401 if auth_token.nil?
        halt 401 unless auth_token == Alfred.config.auth_token
      elsif Alfred.config.username
        self.class.use Rack::Auth::Basic, "Restricted Area" do |username, password|
          (username == Alfred.config.username) && (password == Alfred.config.password)
        end
      end
    end

    [ '/', '/commands' ].each do |root_path|
      get root_path do
        @commands = Alfred::Command.all
        erb(:index)
      end
    end

    [ '/command/:id', '/c/:id' ].each do |command_path|
      get command_path do
        @commands = Alfred::Command.all
        @command = Alfred::Command.find(params[:id])
        erb(:command)
      end
    end

    # Commands API route
    get '/api/commands.json' do
      headers 'Content-Type' => 'application/json'
      @commands = Alfred::Command.all
      @commands.to_json
    end
  end
end
