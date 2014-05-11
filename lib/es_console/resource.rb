module EsConsole
  class Resource
    attr_accessor :client, :default_args

    def initialize(client, default_args={})
      @client       = client
      @default_args = default_args
    end

    def self.def_method(name, opts={})
      method = opts[:method] || name

      if method.is_a? String
        if method.include?('.')
          method = method.split('.')
        end
      end

      define_method name do |args={}|
        res = client

        if method.is_a? Array
          method[0...method.length-1].each do |meth|
            res = res.send meth
          end

          method = method.last
        end

        resp = res.send method, default_args.merge(args)

        if parser = opts[:parser] and parser.is_a? Proc
          resp = parser.call resp
        end

        resp
      end
    end
  end
end
