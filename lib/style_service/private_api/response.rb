module StyleService
  module PrivateAPI
    class Response
      attr_reader :header, :body

      def initialize(header, body)
        begin
          @header = header
          @body = JSON.parse(body)
        rescue
          @body = body
        end
      end
    end
  end
end
