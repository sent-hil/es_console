module EsConsole
  class Resource
    attr_reader :default_args, :client

    def self.def_method(name, resp_parser=nil)
      define_method name do |args={}|
        resp = client.send name, default_args.merge(args)

        if resp_parser and resp_parser.is_a? Proc
          resp = resp_parser.call resp
        end

        resp
      end
    end

    def_method :count, proc {|resp| resp['count']}
  end
end
