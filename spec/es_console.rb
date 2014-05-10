require_relative 'spec_helper'

describe EsConsole do
  it 'starts console' do
    EsConsole::Console.any_instance.should_receive :pry
    EsConsole::Console.start
  end

  subject do
    EsConsole::Console.new
  end

  it 'initializes client' do
    subject.client.class.should == Elasticsearch::Transport::Client
  end

  it 'has default url' do
    subject.url.should == 'http://localhost:9200'
  end

  context 'new url' do
    let(:new_url) {'http://localhost:9201'}

    before do
      subject.url new_url
    end

    it 'sets new url' do
      subject.url.should == new_url
    end

    it 'creates new client' do
      subject.client.transport.options[:url] == new_url
    end
  end
end
