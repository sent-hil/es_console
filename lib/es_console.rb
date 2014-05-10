require 'pry'
require 'elasticsearch'

module EsConsole
  class Console
    attr_reader :client

    def self.start
      new.pry
    end

    def initialize
      configure_defaults
      initialize_client
      configure_pry
    end

    def url(url=nil)
      if url
        @url = url
        initialize_client
      end

      @url
    end

    def stats(opts={})
      resp = client.indices.stats opts

      {}.tap do |result|
        resp['indices'].each do |k, v|
          result[k] = v['primaries']['docs']['count']
        end
      end
    end

    def count(opts={})
      resp = client.count opts
      resp['count']
    end

    private

    def configure_defaults
      @url = 'http://localhost:9200'
    end

    def initialize_client
      @client = Elasticsearch::Client.new url: @url
    end

    def configure_pry
      Pry.config.prompt = [
        proc { "[es]> " },
        proc { "[es]* " },
      ]
    end
  end
end
