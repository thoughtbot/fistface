require 'sinatra/base'

module Sinatra
  module FistFace
    require 'open-uri'

    def self.registered(app)
      app.before do
        one_year_in_seconds = 31536000

        headers 'Cache-Control'               => "public, max-age=#{one_year_in_seconds}",
                'Expires'                     => (Time.now + one_year_in_seconds).httpdate,
                'Access-Control-Allow-Origin' => '*'
      end

      app.get '/:font_face.css' do
        headers['Content-Type'] = 'text/css'
        open("#{ENV['S3_URL']}/#{params[:font_face]}.css").read
      end

      app.get '/:directory/:font_face' do
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
  end
  register FistFace
end