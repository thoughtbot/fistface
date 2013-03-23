require 'sinatra/base'

module Sinatra
  module FistFace
    require 'open-uri'

    def self.registered(app)
      app.before do
        expires 31536000, :public
        headers 'Access-Control-Allow-Origin' => '*'
      end

      app.get '/:font_face.css' do
        content_type 'text/css'
        open("#{ENV['S3_URL']}/#{params[:font_face]}.css").read
      end

      app.get '/:directory/:font_face' do
        content_type(
          case params[:font_face]
            when /\.ttf$/  then 'font/truetype'
            when /\.otf$/  then 'font/opentype'
            when /\.woff$/ then 'font/woff'
            when /\.eot$/  then 'application/vnd.ms-fontobject'
            when /\.svg$/  then 'image/svg+xml'
          end
        )
        open("#{ENV['S3_URL']}/#{params[:directory]}/#{params[:font_face]}").read
      end
    end
  end

  register FistFace
end
