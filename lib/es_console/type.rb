require_relative './resource'

module EsConsole
  class Type < Index
    attr_reader :type

    def initialize(client, index, type)
      @index = index
      @type  = type

      super client, index, {type: type}

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
