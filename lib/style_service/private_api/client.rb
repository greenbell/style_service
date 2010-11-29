# coding: utf-8

module StyleService
  module PrivateAPI
    class Client
      include StyleService::Util

      attr_reader :key, :secret, :site, :port, :ssl

      def initialize(options = {})
        @key    = options[:key]    || raise(ArgumentError, 'application key is blank!')
        @secret = options[:secret] || raise(ArgumentError, 'secret token is blank!')
        @host   = options[:host]   || raise(ArgumentError, 'host is blank!')
        @ssl    = options[:ssl]    || false

        if options[:port]
          @port = options[:port]
        else
          @port = @ssl ? 443 : 80
        end
      end

      def get(path)
        Net::HTTP.version_1_2
        Net::HTTP.start(@host, @port) do |http|
          signature = generate_signature("GET", path)
          header = generate_request_header(signature)

          response = http.get(path, header)
          StyleService::PrivateAPI::Response.new(response.header, response.body)
        end
      end

      def post(path, params)
        Net::HTTP.version_1_2
        Net::HTTP.start(@host, @port) do |http|
          signature = generate_signature("POST", path, params)
          header = generate_request_header(signature)
          body = convert_params_to_string(params)

          response = http.post(path, body, header)
          StyleService::PrivateAPI::Response.new(response.header, response.body)
        end
      end

      def put(path, params)
        Net::HTTP.version_1_2
        Net::HTTP.start(@host, @port) do |http|
          params['_method'] = 'put'
          signature = generate_signature("PUT", path, params)
          header = generate_request_header(signature)
          body = convert_params_to_string(params)

          response = http.post(path, body, header)
          StyleService::PrivateAPI::Response.new(response.header, response.body)
        end
      end

      def delete(path)
        Net::HTTP.version_1_2
        Net::HTTP.start(@host, @port) do |http|
          params = {'_method' => 'delete'}

          signature = generate_signature("DELETE", path, params)
          header = generate_request_header(signature)
          body = convert_params_to_string(params)

          response = http.post(path, body, header)
          StyleService::PrivateAPI::Response.new(response.header, response.body)
        end
      end

      private
        def generate_signature(method, path, params = nil)
          protocol = @ssl ? 'https' : 'http'
          uri = URI.parse("#{protocol}://#{@host}#{path}")

          if params
            query = convert_params_to_string(params)
          else
            query = uri.query
          end

          hmac("#{method}&#{uri.path}&#{query}", @secret)
        end

        def generate_request_header(signature)
          header = {'authorization' => '{"consumer_key": "' + @key + '", "signature": "' + signature + '"}'}
          header
        end

        def convert_params_to_string(params)
          array = []
          params.each do |k,v|
            array << "#{k}=#{v}"
          end
          array.join("&")
        end
    end
  end
end
