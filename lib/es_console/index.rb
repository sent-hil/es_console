require_relative './resource'

module EsConsole
  class Index < Api
    attr_reader :index

    def_method :types, parser: proc {|resp|
      [].tap do |result|
        resp.each do |index, types|
          result << types.keys
        end
      end.flatten.uniq
    }, method: 'indices.get_mapping'

    def_method :mapping, parser: proc {|resp|
      resp.first[1]
    }, method: 'indices.get_mapping'

    def_method :exists, method: 'indices.exists_type',
      first_field: :type

    def_method :delete, parser: proc {|resp|
      resp['ok']
    }, method: 'indices.delete'

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
