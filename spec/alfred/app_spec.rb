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
      @command_file = File.expand_path("#{File.dirname(__FILE__)}/../../spec/commands.yml")
      @commands = Command.load_from_yaml(@command_file)
      @command = @commands.first

      # FIXME: Hack to work around my bad design; remove after it works less stupid.
      Command.should_receive(:from_yaml).and_return(@commands)
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
