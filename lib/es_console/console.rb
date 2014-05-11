require 'forwardable'

module EsConsole
  class Console
    extend Forwardable
    def_delegators :@api, :count, :stats, :index

    attr_reader :api

    def initialize
      configure_defaults
      initialize_client
      initialize_api
      configure_pry
    end

    def url(url=nil)
      if url
        @url = url
        initialize_client
        initialize_api
      end

      @url
    end

    private

    def configure_defaults
      @url = 'http://localhost:9200'
      @default_args = {}
    end

    def initialize_client
      @client = Elasticsearch::Client.new url: @url
    end

    def initialize_api
      @api = Api.new @client, @default_args
    end

    def configure_pry
      Pry.config.prompt = [
        proc { "[es]> " },
        proc { "[es]* " },
      ]
    end
  end
end
