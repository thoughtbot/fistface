# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'fistface/version'

Gem::Specification.new do |s|
  s.add_dependency('sinatra', '~> 1.1')
  s.add_development_dependency('rack-test', '~> 0.6')
  s.add_development_dependency('rake', '~> 10.0')
  s.add_development_dependency('rspec', '~> 2.13')
  s.add_development_dependency('timecop', '~> 0.6')
  s.authors = ['Dan Croak']
  s.description = 'Pow. Right in the kisser.'
  s.email = 'support@thoughtbot.com'
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.files = `git ls-files`.split("\n")
  s.homepage = 'http://github.com/thoughtbot/fistface'
  s.name = 'fistface'
  s.require_paths = ['lib']
  s.summary = 'DIY @font-face web service'
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.version = FistFace::VERSION
end
