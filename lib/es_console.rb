require 'pry'
require 'elasticsearch'

require_relative './es_console/console'
require_relative './es_console/api'
require_relative './es_console/index'
require_relative './es_console/type'

module EsConsole
  def self.start
    Console.new.pry
  end
end
