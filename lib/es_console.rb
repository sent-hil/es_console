require 'pry'

module EsConsole
  class Console
    def self.start
      new.pry
    end

    def initialize
      configure_defaults
    end

    def url(url=nil)
      @url = url  if url
      @url
    end

    def configure_defaults
      @url = 'http://localhost:9200'
    end
  end
end
