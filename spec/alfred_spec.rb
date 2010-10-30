require 'spec_helper'

describe Alfred do

  it 'should have a config hash' do
    ENV['ALFRED_CONFIG'].should_not be_nil
    Alfred.config.should == YAML.load_file(ENV['ALFRED_CONFIG'])
  end

end
