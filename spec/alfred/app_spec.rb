require 'spec_helper'

describe Alfred::App do
  include Rack::Test::Methods

  before(:all) do
    @config_file = File.expand_path("#{File.dirname(__FILE__)}/../alfred.yml")
    Alfred.configure!(@config_file)

    @command_file = File.expand_path("#{File.dirname(__FILE__)}/../../spec/commands.yml")
    @commands = Command.load_yaml!(@command_file)
    @command = @commands.first
  end

  describe 'API' do
    before(:all) do
      @token = Alfred.config.auth_token
    end

    it 'should be authenticated' do
      get '/api/authenticate.json', {}, { 'HTTP_X_AUTH_TOKEN' => @token }
      last_response.should be_ok
    end

    it 'should not be authenticated' do
      get '/api/authenticate.json', {}, { 'HTTP_X_AUTH_TOKEN' => 'fake_token' }
      last_response.should_not be_ok
      last_response.status.should == 401
    end

    it 'returns command JSON' do
      get '/api/commands.json', {}, { 'HTTP_X_AUTH_TOKEN' => @token }
      last_response.should be_ok

      json = JSON.parse(last_response.body)
      json.should_not be_empty
    end
  end

  describe 'Web' do
    before(:all) do
      @username = Alfred.config.username
      @password = Alfred.config.password

      authorize(@username, @password)
    end

    it 'responds to /' do
      get '/'
      last_response.should be_ok
    end

    describe '/command' do
      it 'shows the command output' do
        get "/command/#{@command.id}"
        last_response.should be_ok
      end
    end # /command
  end

end
