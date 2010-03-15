require 'spec_helper'

describe Alfred::Command do

  it 'can execute arbitrary shell commands' do
    Command.exec('hostname').should == %x[hostname].chomp
  end

  it '#initialize accepts an array' do
    command = Command.new('Host', 'hostname')
    command.name.should == 'Host'
  end

  it '#initialize accepts a hash' do
    command = Command.new({:name => 'Host', :exec => 'hostname'})
    command.name.should == 'Host'
  end

  it 'complains if missing raw command input' do
    lambda do
      Command.new('no command')
    end.should raise_error(Alfred::CommandError)
  end

  describe 'instance' do
    before(:each) do
      @options = {:name => 'Host', :exec => 'hostname'}
      @command = Command.new(@options)
    end

    it 'stores the raw command string' do
      @command.raw.should == @options[:exec]
    end

    it 'runs the command' do
      @command.exec!
      @command.output.should_not be_nil
    end
  end # instance

end
