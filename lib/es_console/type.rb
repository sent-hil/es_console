require_relative './resource'

module EsConsole
  class Type < Resource
    attr_reader :index, :type

    def initialize(client, index, type)
      @client = client
      @index  = index
      @type   = type

      @default_args = {index: index, type: type}

      configure_pry
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
