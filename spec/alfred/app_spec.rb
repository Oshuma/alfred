require 'spec_helper'

describe Alfred::App do
  include Rack::Test::Methods

  it 'responds to /' do
    get '/'
    last_response.should be_ok
  end

  it 'responds with text/plain if curling' do
    header 'User-Agent', 'curl/7.16.3'
    get '/'
    last_response.should be_ok
    last_response.headers['Content-Type'].should == 'text/plain'
  end

  describe '/command' do
    before(:each) do
      @command_file = File.dirname(__FILE__) + '/../../config/commands.spec.yml'
      @commands = Command.from_yaml(@command_file)
      @command = @commands.first
    end

    it 'shows the command output' do
      get "/command/#{@command.id}"
      last_response.should be_ok
    end

    it 'responds with text/plain if curling' do
      header 'User-Agent', 'curl/7.16.3'
      get "/command/#{@command.id}"
      last_response.should be_ok
      last_response.headers['Content-Type'].should == 'text/plain'
    end
  end # /command

end
