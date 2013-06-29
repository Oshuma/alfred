require 'sinatra/base'

module Alfred
  class App < Sinatra::Base

    set :root, File.join(Dir.pwd, 'app')
    set :views, File.join(settings.root, 'views')
    set :public_folder, File.join(settings.root, 'public')

    enable :static

    configure do
    end

    helpers do
    end

    before do
      @hostname = Alfred::Command.exec('hostname')
    end

  end
end
