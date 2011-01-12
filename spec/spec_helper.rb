$: << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'app'
require 'rack/test'
require 'timecop'

ENV['RACK_ENV'] = 'test'
ENV['S3_URL']   = 'spec/fixtures'
