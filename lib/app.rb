require 'rubygems'
require 'open-uri'
require 'bundler'

Bundler.require

class App < Sinatra::Base
  set :app_file, __FILE__

  before do
    headers 'Cache-Control'               => 'public, max-age=31536000',
            'Expires'                     => (Time.now + 31536000).httpdate,
            'Access-Control-Allow-Origin' => '*'
  end

  get '/:font_face.css' do
    headers['Content-Type'] = 'text/css'
    open("#{ENV['S3_URL']}/#{params[:font_face]}.css").read
  end

  get '/:directory/:font_face' do
    headers['Content-Type'] = case params[:font_face]
                                when /\.ttf$/  then 'font/truetype'
                                when /\.otf$/  then 'font/opentype'
                                when /\.woff$/ then 'font/woff'
                                when /\.eot$/  then 'application/vnd.ms-fontobject'
                                when /\.svg$/  then 'image/svg+xml'
                              end
    open("#{ENV['S3_URL']}/#{params[:directory]}/#{params[:font_face]}").read
  end
end
