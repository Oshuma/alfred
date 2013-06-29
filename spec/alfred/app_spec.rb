require 'spec_helper'

describe Alfred::App do
  include Rack::Test::Methods

  it 'responds to /' do
    get '/'
    last_response.should be_ok
  end

  describe '/command' do
    before(:each) do
      @command_file = File.expand_path("#{File.dirname(__FILE__)}/../../spec/commands.yml")
      @commands = Command.load_yaml!(@command_file)
      @command = @commands.first
    end

    it 'shows the command output' do
      get "/command/#{@command.id}"
      last_response.should be_ok
    end
  end # /command

end
