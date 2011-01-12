$: << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'bundler'

Bundler.require

require 'fistface'
require 'rack/test'
require 'timecop'

ENV['RACK_ENV'] = 'test'
ENV['S3_URL']   = 'spec/fixtures'
