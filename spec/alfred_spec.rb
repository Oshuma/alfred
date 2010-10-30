require 'spec_helper'

describe Alfred do

  it 'should have a config hash' do
    ENV['ALFRED_CONFIG'].should_not be_nil
    Alfred.config.should == YAML.load_file(ENV['ALFRED_CONFIG'])
  end

  describe 'authentication' do
    before(:each) do
      @good_key = Alfred.config['auth']['api_key']
      @bad_key  = "THISISVERYVERYBAD"
    end

    it 'returns true on success' do
      Alfred.authenticate(@good_key).should be_true
    end

    it 'returns false on failure' do
      Alfred.authenticate(@bad_key).should be_false
    end
  end # authentication

end
