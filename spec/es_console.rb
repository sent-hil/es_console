require_relative 'spec_helper'

describe EsConsole do
  it 'starts console' do
    EsConsole::Console.any_instance.should_receive :pry
    EsConsole.start
  end

  subject do
    EsConsole::Console.new
  end

  it 'initializes client' do
    subject.api.client.class.should == Elasticsearch::Transport::Client
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
      subject.api.client.transport.options[:url] == new_url
    end
  end

  it 'gets list' do
    VCR.use_cassette 'all_list' do
      subject.list.should == {'greeting'=>2, 'myindexa'=>1, 'myindex'=>1}
    end
  end

  it 'gets all count' do
    VCR.use_cassette 'all_count' do
      subject.count.should == 4
    end
  end

  it 'changes context to index' do
    EsConsole::Index.any_instance.should_receive :pry
    subject.index 'greeting'
  end

  context EsConsole::Index do
    subject do
      client = Elasticsearch::Client.new
      index  = EsConsole::Index.new(client, 'greeting')

      index
    end

    it 'gets count' do
      VCR.use_cassette 'index_count' do
        subject.count.should == 2
      end
    end

    it 'gets types' do
      VCR.use_cassette 'index_types' do
        subject.types.should == ['hello', 'another']
      end
    end

    it 'gets mapping' do
      VCR.use_cassette 'index_mapping' do
        subject.mapping.should_not == nil
      end
    end

    it 'checks for existence' do
      VCR.use_cassette 'index_type_exists' do
        subject.exists('hello').should == true
      end
    end

    it 'deletes' do
      VCR.use_cassette 'index_delete' do
        subject.delete.should == true
      end
    end
  end

  context EsConsole::Type do
    subject do
      client = Elasticsearch::Client.new
      type   = EsConsole::Type.new(client, 'greeting', 'hello')

      type
    end

    it 'gets count' do
      VCR.use_cassette 'type_count' do
        subject.count.should == 1
      end
    end

    it 'gets by id' do
      VCR.use_cassette 'type_get_doc' do
        subject.get('1').should_not == nil
      end
    end

    it 'gets source by id' do
      VCR.use_cassette 'type_get_source' do
        subject.get_source('1').should_not == nil
      end
    end

    it 'checks for existence of document' do
      VCR.use_cassette 'type_exists' do
        subject.exists('1').should == true
        subject.exists?('1').should == true
      end
    end

    it 'deletes by id' do
      VCR.use_cassette 'type_delete_doc' do
        subject.delete('1').should_not == nil
      end
    end

    it 'deletes mapping' do
      VCR.use_cassette 'type_delete_mapping' do
        subject.delete_mapping.should == true
      end
    end

    it 'creates document' do
      VCR.use_cassette 'type_create_document' do
        subject.create(1, {name: 'Jones'}).should == {'ok'=>true, 'version'=>1}
      end
    end
  end
end
