# coding: utf-8

require 'rubygems'
require 'bundler'
require 'openssl'

ENV['BUNDLER_GEMFILE'] = File.expand_path("../../Gemfile", __FILE__)
Bundler.setup
Bundler.require

require 'webmock/rspec'
