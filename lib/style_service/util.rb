# coding: utf-8

module StyleService
  module Util
    private
      def hmac(str, secret)
        hmac = OpenSSL::HMAC.new(secret, OpenSSL::Digest::SHA1.new)
        hmac.update(str).to_s
      end
  end
end
