require 'rubygems'
require 'bundler'
require 'open-uri'
Bundler.require

class App < Sinatra::Base
  set :app_file, __FILE__

  before do
    headers 'Cache-Control'               => 'public, max-age=31536000',
            'Expires'                     => (Time.now + 31536000).httpdate,
            'Access-Control-Allow-Origin' => '*'
  end

  get '/:font_face.css' do
    open("#{ENV['S3_URL']}/#{params[:font_face]}.css").read
  end

  get '/:font_face' do
    headers['Content-Type'] = case params[:font_face]
                                when /\.ttf$/  then 'font/truetype'
                                when /\.otf$/  then 'font/opentype'
                                when /\.woff$/ then 'font/woff'
                                when /\.eot$/  then 'application/vnd.ms-fontobject'
                                when /\.svg$/  then 'image/svg+xml'
                              end
    open("#{ENV['S3_URL']}/#{params[:font_face]}").read
  end
end
