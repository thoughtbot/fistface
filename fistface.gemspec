# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fistface/version"

Gem::Specification.new do |s|

  # Dependencies
  s.add_dependency('sinatra', '~> 1.1')
  s.add_development_dependency "rspec"
  s.add_development_dependency "rack-test"
  s.add_development_dependency "timecop"

  #Configuration
  s.name        = 'fistface'
  s.version     = Fistface::VERSION
  s.authors     = ['Dan Croak']
  s.email       = 'support@thoughtbot.com'
  s.homepage    = 'http://github.com/thoughtbot/fistface'
  s.summary     = 'DIY @font-face web service'
  s.description = 'Pow. Right in the kisser.'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
