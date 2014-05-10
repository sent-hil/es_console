require 'pry'

module EsConsole
  class Console
    def self.start
      new.pry
    end
  end
end
