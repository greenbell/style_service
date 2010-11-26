# coding: utf-8

module StyleService
  module PrivateAPI
    class Client
      attr_reader :key, :secret, :site, :port, :ssl

      def initialize(options = {})
        @key    = options[:key]    || raise(ArgumentError, 'application key is blank!')
        @secret = options[:secret] || raise(ArgumentError, 'secret token is blank!')
        @site   = options[:host]   || raise(ArgumentError, 'host is blank!')
        @ssl    = options[:ssl]    || false

        if options[:port]
          @port = options[:port]
        else
          @port = @ssl ? 443 : 80
        end
      end
    end
  end
end
