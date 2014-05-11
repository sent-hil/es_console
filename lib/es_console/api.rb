require_relative './resource'

module EsConsole
  class Api < Resource
    def_method :count, parser: proc {|resp| resp['count']}
    def_method :stats, parser: proc {|resp|
      {}.tap do |result|
        resp['indices'].each do |k, v|
          result[k] = v['primaries']['docs']['count']
        end
      end
    }, method: 'indices.stats'

    def index(index)
      Index.new(client, index).pry
    end
  end
end
