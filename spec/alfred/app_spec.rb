require 'spec_helper'

describe Alfred::App do
  include Rack::Test::Methods

  it 'responds to /' do
    get '/'
    last_response.should be_ok
  end
end
