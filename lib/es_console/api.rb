require_relative './resource'

module EsConsole
  class Api < Resource
    def_method :count, parser: proc {|resp| resp['count']}
    def_method :list, parser: proc {|resp|
      {}.tap do |result|
        resp['indices'].each do |k, v|
          result[k] = v['primaries']['docs']['count']
        end
      end
    }, method: 'indices.stats'

    def_method :create_template, parser: proc {|resp|
      resp['ok']
    }, method: 'indices.put_template',
    first_field: :name, second_field: :body

    def_method :get_template,
      method: 'indices.get_template', first_field: :name

    def_method :delete_template, parser: proc {|resp|
      resp['ok']
    }, method: 'indices.delete_template',
    first_field: :name


    def index(index)
      Index.new(client, index).pry
    end
  end
end
