# coding: utf-8
require File.expand_path('../init', __FILE__)

Gem::Specification.new do |s|
  s.name                      = 'style_service'
  s.version                   = StyleService::VERSION
  s.date                      = %q{2010-11-29}
  s.authors                   = ["Dai Akatsuka"]
  s.email                     = %q{d.akatsuka@ist-corp.jp}
  s.description               = %q{Style Service's Application Platform Interface}
  s.summary                   = %q{Style Service's Application Platform Interface}
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version          = %q{1.3.7}
  s.files                     = `git ls-files`.split("\n")
  s.test_files                = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths             = ['lib']

  s.add_runtime_dependency     'json',    '>=1.4.6'
  s.add_development_dependency 'bundler', '>=1.0.0'
  s.add_development_dependency 'rspec',   '>=2.0.1'
  s.add_development_dependency 'webmock', '>=1.6'
end
