require_relative './resource'

module EsConsole
  class Index < Resource
    def_method :count, parser: proc {|resp| resp['count']}

    attr_reader :index

    def initialize(client, index, default_args={})
      @index = index

      super client, default_args.merge({index: index})

      configure_pry
    end

    def type(type)
      Type.new(client, index, type).pry
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
