require 'spec_helper'

describe Module do

  it 'has a mattr_reader class method' do
    module ReaderModule
      mattr_reader :attribute
      @@attribute = 'the value'
    end
    ReaderModule.should respond_to(:attribute)
    ReaderModule.attribute.should == 'the value'
  end

  it 'has a mattr_writer class method' do
    module WriterModule
      mattr_writer :attribute
    end
    WriterModule.attribute = 'the value'
    WriterModule.class_variable_get(:@@attribute).should == 'the value'
  end

  it 'has a mattr_accessor class method' do
    module AccessorModule; end # Setup a module so we can watch it with:
    AccessorModule.should_receive(:mattr_reader).with(:attribute)
    AccessorModule.should_receive(:mattr_writer).with(:attribute)

    module AccessorModule
      mattr_accessor :attribute
    end
  end

end
