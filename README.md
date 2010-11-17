Setup
-----

Comes with an .rvmrc set up for Ruby Enterprise Edition.

    gem install bundler shotgun thin && bundle install

Development
-----------

    shotgun config.ru S3_URL=https://thoughtbot-fonts.s3.amazonaws.com

Production
----------

    heroku config:add S3_URL=https://thoughtbot-fonts.s3.amazonaws.com

Where S3_URL is the place you put your .otf, .ttf, .woff, and .eot files.
Do not include a trailing slash.
