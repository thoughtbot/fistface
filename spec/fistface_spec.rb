require 'spec_helper'

describe 'FistFace' do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  context 'when I GET a font stylesheet by convention of font-name.css' do
    before do
      Timecop.freeze(first_of_january)

      get 'chunk.css'
    end

    after { Timecop.return }

    it 'responds with HTTP status OK' do
      last_response.should be_ok
    end

    it 'has the @font-face declaration in the CSS body' do
      last_response.body.should == File.read('spec/fixtures/chunk.css')
    end

    it 'is in the CSS Content-Type' do
      last_response.content_type.should == 'text/css;charset=utf-8'
    end

    it 'wildcards the Access-Control-Allow-Origin header so Firefox can access the file' do
      last_response.headers['Access-Control-Allow-Origin'].should == '*'
    end

    it 'HTTP caches the file for a year in HTTP accelerators like Varnish' do
      last_response.headers['Cache-Control'].should == 'public, max-age=31536000'
    end

    it "HTTP caches the file for a year in the user's browser" do
      last_response.headers['Expires'].should == (Time.now + 31536000).httpdate
    end
  end

  context 'when I GET a font file by convention of font-name/font-name.ttf' do
    before do
      Timecop.freeze(first_of_january)

      get 'chunk/chunk.ttf'
    end

    after { Timecop.return }

    it 'responds with HTTP status OK' do
      last_response.should be_ok
    end

    it 'is in the truetype Content-Type' do
      last_response.content_type.should == 'font/truetype'
    end

    it 'wildcards the Access-Control-Allow-Origin header so Firefox can access the file' do
      last_response.headers['Access-Control-Allow-Origin'].should == '*'
    end

    it 'HTTP caches the file for a year in Varnish' do
      last_response.headers['Cache-Control'].should == 'public, max-age=31536000'
    end

    it "HTTP caches the file for a year in the user's browser" do
      last_response.headers['Expires'].should == (Time.now + 31536000).httpdate
    end
  end

  context 'when I GET an opentype font' do
    before { get 'chunk/chunk.otf' }

    it 'is in the opentype Content-Type' do
      last_response.content_type.should == 'font/opentype'
    end
  end

  context 'when I GET a web open font format font' do
    before { get 'chunk/chunk.woff' }

    it 'is in the web open font format Content-Type' do
      last_response.content_type.should == 'font/woff'
    end
  end

  context 'when I GET an embedded opentype font' do
    before { get 'chunk/chunk.eot' }

    it 'is in the embedded opentype Content-Type' do
      last_response.content_type.should == 'application/vnd.ms-fontobject'
    end
  end

  context 'when I GET an svg font' do
    before { get 'chunk/chunk.svg' }

    it 'is in the svg Content-Type' do
      last_response.content_type.should == 'image/svg+xml'
    end
  end

  context 'when I GET an assets via certain domain' do
    before do
      ENV['ALLOW_ORIGIN'] = "*.example.com"
      get 'chunk/chunk.svg'
    end

    it 'limits the Access-Control-Allow-Origin header to the certain domain' do
      last_response.headers['Access-Control-Allow-Origin'].should == '*.example.com'
    end
  end

  def first_of_january
    Date.parse('January 1, 2011')
  end
end
