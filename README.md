Fist Face
=========

DIY @font-face web service.

Usage
-----

In your web app:

    <link href="http://replace-me.com/font-name.css" rel="stylesheet" type="text/css">

Replace the href with the URL of your @font-face web service.

Features
--------

* Fixes the Access-Control-Allow-Origin problem in Firefox and other browsers
* HTTP caches fonts so they are downloaded only once by the same browser
* Content-Type always correct for .ttf, .otf, .woff, .eot, and .svg fonts

Setup
-----

Create a Gemfile:

    source 'http://rubygems.org'
    gem 'sinatra',  '~> 1.1'
    gem 'fistface', '~> 1.0'

Create a rackup file (config.ru):

    require 'rubygems'
    require 'bundler'
    Bundler.require
    run Sinatra::FistFace
    run Sinatra::Application

Prepare the app for production:

    bundle install
    git init
    git add .
    git commit -m 'Creating a Fist Face instance'

Create the production environment. Use Heroku's Bamboo stack in order to use
[Varnish](https://devcenter.heroku.com/articles/http-caching):

    heroku create your-app-name-here --stack bamboo-mri-1.9.2

Add your S3 bucket:

    heroku config:add S3_URL=https://your-bucket.s3.amazonaws.com

Do not include a trailing slash.

S3_URL is the URL of the asset host which stores your @font-face definitions in CSS files.

For each font you want to serve, upload a CSS file to your asset host like:

    @font-face {
      font-family: 'Chunk';
      font-weight: normal;
      font-style: normal;
      src: local('☺'), url('http://replace-me.com/chunk/chunk.ttf') format('truetype');
    }

Fist Face uses a directory-and-file convention like this:

    font-name.css
    font-name/
      font-name.eot
      font-name.otf
      font-name.svg
      font-name.ttf
      font-name.woff

It is up to you to determine how many formats you need to include in your CSS file.

Upload each font file using that convention.

Deploy your @font-face web service:

    git push heroku master

Start serving fonts!

Patches
-------

Please use Github Issues and Pull Requests for any patches.

To run the Sinatra app locally:

    gem install bundler
    bundle install
    S3_URL=https://your-bucket.s3.amazonaws.com rackup

To run the specs:

    rspec spec/app_spec.rb

Credits
-------

![thoughtbot](http://thoughtbot.com/images/tm/logo.png)

Fist Face is maintained and funded by [thoughtbot, inc](http://thoughtbot.com/community)

Thank you to all [the contributors](https://github.com/thoughtbot/fistface/contributors)!

The names and logos for thoughtbot are trademarks of thoughtbot, inc.

License
-------

Fist Face is Copyright © 2010-2012 thoughtbot. It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
