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
    end

    def url(url=nil)
      if url
        @url = url
        initialize_client
      end

      @url
    end

    def stats
    end

    private

    def configure_defaults
      @url    = 'http://localhost:9200'
    end

    def initialize_client
      @client = Elasticsearch::Client.new url: @url
    end
  end
end
