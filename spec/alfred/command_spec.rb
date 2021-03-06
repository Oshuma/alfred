require 'spec_helper'

describe Alfred::Command do

  before(:each) do
    @command_file = File.expand_path("#{File.dirname(__FILE__)}/../../spec/commands.yml")
  end

  it 'can execute arbitrary shell commands' do
    Command.exec('hostname').should == %x[hostname]
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

  describe 'YAML file' do
    it 'reads commands from a file' do
      Command.load_yaml!(@command_file)
      Command.all.should_not be_empty
    end
  end # YAML file

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

    it 'runs the command if output is nil' do
      @command.instance_variable_get(:@output).should be_nil
      @command.output.should_not be_nil # runs exec! in #output
    end

    it 'generates a proper id' do
      command = Command.new({ :name => 'The Command', :exec => 'hostname' })
      command.id.should == 'the_command'
    end

    it 'uses a custom id (hash constructor)' do
      @options[:id] = 'the_command'
      command = Command.new(@options)
      command.id.should == 'the_command'
    end

    it 'uses a custom id (array constructor)' do
      command = Command.new('Name', 'hostname', 'the_command')
      command.id.should == 'the_command'
    end
  end # instance

end
