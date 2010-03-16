require 'spec_helper'

describe Alfred::Client do
  it 'should remove the command from the processed args' do
    args   = ['report', '-h', '80']
    client = Client.new(args)
    client_args = client.instance_variable_get(:@args)
    client_args.should_not include('report')
  end
end
