require_relative 'spec_helper'

describe EsConsole do
  it 'starts console' do
    EsConsole::Console.any_instance.should_receive :pry
    EsConsole::Console.start
  end

  subject do
    EsConsole::Console.new
  end

  context '#url' do
    it 'has default url' do
      subject.url.should == 'http://localhost:9200'
    end

    it 'sets new url' do
      new_url = 'http://localhost:9201'

      subject.url new_url
      subject.url.should == new_url
    end
  end
end
