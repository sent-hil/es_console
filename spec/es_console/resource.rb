require_relative '../spec_helper'

describe EsConsole::Resource do
  let(:client) do
    double count: {'count'=>1}
  end

  it 'sends symbol method to client' do
    resource = Class.new described_class
    resource.def_method :count

    resource.new(client).count['count'].should == 1
  end

  it 'sends string method to client' do
    resource = Class.new described_class
    resource.def_method 'count'

    resource.new(client).count['count'].should == 1
  end

  it 'accepts different name to send to client' do
    resource = Class.new described_class
    resource.def_method :new_count, method: :count

    resource.new(client).new_count['count'].should == 1
  end

  it 'accepts multiple client methods calls' do
    to_f_client = double :to_f => 1.0
    client = double :count => to_f_client

    resource = Class.new described_class
    resource.def_method :count, method: 'count.to_f'

    resource.new(client).count.should == 1.0
  end

  it 'accepts parser to parse repsonse from client' do
    resource = Class.new described_class
    resource.def_method :count, parser: proc {|r| r['count']}

    resource.new(client).count.should == 1
  end

  it 'merges default_args with each client method call' do
    resource = Class.new described_class
    resource.def_method :count

    client = double 'client'
    client.should_receive(:count).with({a: 1})

    resource.new(client, {a: 1}).count
  end

  it 'accepts id as first arg' do
    resource = Class.new described_class
    resource.def_method :count

    client = double 'client'
    client.should_receive(:count).with({id: 1}).and_return(1)

    resource.new(client).count(1).should == 1
  end

  it 'merges id with default args' do
    resource = Class.new described_class
    resource.def_method :count

    client = double 'client'
    client.should_receive(:count).with({id:1, a:1}).and_return(1)

    resource.new(client, {a:1}).count(1).should == 1
  end

  it 'accepts hash as first arg' do
    resource = Class.new described_class
    resource.def_method :count

    client = double 'client'
    client.should_receive(:count).with({id: 1}).and_return(1)

    resource.new(client).count({id:1}).should == 1
  end

  it 'accepts id and hash as args' do
    resource = Class.new described_class
    resource.def_method :count

    client = double 'client'
    client.should_receive(:count).with({id: 1, a:1}).and_return(1)

    resource.new(client).count(1, {a:1}).should == 1
  end

  it 'merges id and hash with default args' do
    resource = Class.new described_class
    resource.def_method :count

    client = double 'client'
    client.should_receive(:count).with({id:1, a:1, b:1}).and_return(1)

    resource.new(client, {a:1}).count(1, {b:1}).should == 1
  end
end
