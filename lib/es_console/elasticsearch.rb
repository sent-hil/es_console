require_relative './resource'

module EsConsole
  class Api < Resource
    def_method :count, parser: proc {|resp| resp['count']}
    def_method :stats, method: "indices.stats", parser: proc {|resp|
      {}.tap do |result|
        resp['indices'].each do |k, v|
          result[k] = v['primaries']['docs']['count']
        end
      end
    }

    def initialize
      configure_defaults
      initialize_client
      configure_pry

      @default_args = {}
    end

    def url(url=nil)
      if url
        @url = url
        initialize_client
      end

      @url
    end

    def index(index)
      Index.new(client, index).pry
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
