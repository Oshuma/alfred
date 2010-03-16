require 'sinatra/base'
require 'erb'

module Alfred
  # TODO: Split the views into subdirs.
  class App < Sinatra::Base

    set :root, "#{File.dirname(__FILE__)}/../../app"
    enable :static

    before do
      if request.env['HTTP_USER_AGENT'] =~ /^(curl\/[\d\.]+)/
        headers['Content-Type'] = 'text/plain'
        @text_request = true
      end
      @hostname = Alfred::Command.exec('hostname')
      @command_file = File.dirname(__FILE__) + '/../../config/commands.yml'
      @commands = Alfred::Command.from_yaml(@command_file)
    end

    helpers do
      include Rack::Utils
      alias_method :h, :escape_html
    end

    get '/' do
      @text_request ? erb(:index_text, :layout => false) : erb(:index)
    end

    get '/commands' do
      if @text_request
        @commands.map { |c| "#{c.name} (#{c.id})" }.join("\n")
      else
        erb :commands
      end
    end

    [ '/command/:id', '/c/:id' ].each do |command_path|
      get command_path do
        @command = @commands.select { |c| params[:id] == c.id }.first
        @text_request ? @command.output : erb(:command)
      end
    end

  end
end
