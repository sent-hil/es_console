module EsConsole
  class Index
    attr_reader :client, :index

    def initialize(client, index)
      @client = client
      @index  = index

      configure_pry
    end

    private

    def configure_pry
      Pry.config.prompt = [
        proc { "[es:'#{index}']> " },
        proc { "[es:'#{index}']* " },
      ]
    end
  end
end
