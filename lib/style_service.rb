# coding: utf-8
$:.unshift(File.dirname(__FILE__))

module StyleService
  autoload :Util,       'style_service/util'
  autoload :VERSION,    'style_service/version'

  module PrivateAPI
    autoload :Client,   'style_service/private_api/client'
    autoload :Response, 'style_service/private_api/response'
  end
end
