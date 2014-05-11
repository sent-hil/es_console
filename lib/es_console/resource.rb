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
      second_field = opts[:second_field]

      if method.is_a? String
        method = method.split('.')
      end

      define_method name do |*args|
        cl = client

        if method.is_a? Array
          method[0...method.length-1].each do |meth|
            cl = cl.send meth
          end

          meth = method.last
        end

        if args.empty?
          resp = cl.send meth, default_args
        elsif args[0].is_a? Hash
          resp = cl.send meth, default_args.merge(args[0])
        elsif args[1].is_a? Hash
          second = if second_field
            {second_field => args[1]}
          else
            args[1]
          end

          resp = cl.send meth, default_args.merge(
            {first_field => args[0]}.merge(second)
          )
        else
          resp = cl.send meth, default_args.merge(
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
