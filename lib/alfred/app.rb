require 'sinatra/base'
require 'erb'

module Alfred
  class App < Sinatra::Base

    set :root, "#{File.dirname(__FILE__)}/../../app"
    enable :static

    before do
      @hostname = %x[ hostname ]
    end

    get '/' do
      @disk_usage = %x[ df -h ]
      @memory = %x[ free ]
      @users = %x[ w ]
      erb :index
    end

  end
end
