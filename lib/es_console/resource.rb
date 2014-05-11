module EsConsole
  class Resource
    attr_accessor :client, :default_args

    def initialize(client, default_args={})
      @client       = client
      @default_args = default_args
    end

    def self.def_method(name, opts={})
      method = opts[:method] || name
      first_field = opts[:first_field] || :id

      if method.is_a? String
        if method.include?('.')
          method = method.split('.')
        end
      end

      define_method name do |*args|
        res = client

        if method.is_a? Array
          method[0...method.length-1].each do |meth|
            res = res.send meth
          end

          method = method.last
        end

        if args.empty?
          resp = res.send method, default_args
        elsif args[0].is_a? Hash
          resp = res.send method, default_args.merge(args[0])
        elsif args[1].is_a? Hash
          resp = res.send method, default_args.merge(
            {first_field => args[0]}.merge(args[1])
          )
        else
          resp = res.send method, default_args.merge(
            {first_field => args[0]}
          )
        end

        if parser = opts[:parser] and parser.is_a? Proc
          resp = parser.call resp
        end

        resp
      end
    end
  end
end
