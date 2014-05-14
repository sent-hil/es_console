module EsConsole
  class Console
    def method_missing(name, *args, &blk)
      if @api.respond_to? name
        @api.send name, *args, &blk
      else
        super name, *args, &blk
      end
    end

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
