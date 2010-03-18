require 'sinatra/base'
require 'erb'

module Alfred
  # TODO: Split the views into subdirs.
  class App < Sinatra::Base

    set :root, "#{File.dirname(__FILE__)}/../../app"
    enable :static

    before do
      @hostname = Alfred::Command.exec('hostname')
      @command_file = File.dirname(__FILE__) + '/../../config/commands.yml'
      @commands = Alfred::Command.from_yaml(@command_file)

      if text_request?
        headers['Content-Type'] = 'text/plain'
        @layout = false
      else
        @layout = 'layout'
      end
    end

    helpers do
      include Rack::Utils
      alias_method :h, :escape_html

      def display(template, options = {})
        if options[:layout].nil?
          if @layout
            layout = (@layout.to_sym rescue :"#{@layout}")
            options[:layout] = layout
          else
            options[:layout] = @layout
          end
        end
        erb(template.to_sym, options)
      end

      def text_request?
        request.user_agent =~ /^(curl\/[\d\.]+)/
      end
    end

    get '/' do
      display(text_request? ? :index_text : :index)
    end

    get '/commands' do
      if text_request?
        @commands.map { |c| "#{c.name} (#{c.id})" }.join("\n")
      else
        display(:commands)
      end
    end

    [ '/command/:id', '/c/:id' ].each do |command_path|
      get command_path do
        @command = @commands.select { |c| params[:id] == c.id }.first
        text_request? ? @command.output : display(:command)
      end
    end

  end
end
