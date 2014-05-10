module EsConsole
  class Type
    attr_reader :client, :index, :type

    def initialize(client, index, type)
      @client = client
      @index  = index
      @type   = type

      configure_pry
    end

    def count(opts={})
      resp = client.count(
        {index:index, type:type}.merge(opts)
      )

      resp['count']
    end

    private

    def configure_pry
      Pry.config.prompt = [
        proc { "[es:'#{index}:#{type}']> " },
        proc { "[es:'#{index}:#{type}']* " },
      ]
    end
  end
end
