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
    last_response.headers['Content-Type'].should == 'text/plain'
  end
end
