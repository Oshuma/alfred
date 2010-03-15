require 'spec_helper'

describe Alfred::Command do

  it 'can execute arbitrary shell commands' do
    Command.exec('hostname').should_not be_nil
  end

end
