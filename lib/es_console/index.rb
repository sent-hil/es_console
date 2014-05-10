require_relative './resource'

module EsConsole
  class Index < Resource
    attr_reader :index

    def initialize(client, index)
      @client = client
      @index  = index

      @default_args = {index: index}

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
