require 'pry'
require 'elasticsearch'

require_relative './es_console/elasticsearch'
require_relative './es_console/index'
require_relative './es_console/type'

module EsConsole
  def self.start
    Api.new.pry
  end
end
