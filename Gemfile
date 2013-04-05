source 'https://rubygems.org'

gem 'rails', '3.2.8'

#DBMS
group :development, :test do
  gem 'sqlite3'
end

group :development do
 gem 'foreman'
 gem 'heroku'
 gem 'heroku_san'
 gem 'taps'
 gem 'pry'
 gem "better_errors"
 gem "binding_of_caller"
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails', :require => false
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'growl'
  #gem 'ruby-growl'
  #gem 'libnotify'
  gem 'turn', :require => false
end

group :production do
  gem 'pg'
 gem 'newrelic_rpm'
 gem 'fog'
 gem 'memcachier'
 gem 'dalli'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
  gem "font-awesome-sass-rails", "~> 2.0.0.0"
end

# editing-rendering
gem 'haml-rails'
gem 'coffee-filter'
gem 'jquery-rails'
gem 'bootstrap-sass', '~> 2.0.3'
gem "twitter-bootstrap-rails"
gem 'bootstrap-will_paginate'
gem 'bootstrap_forms'
gem 'twitter_bootstrap_form_for'
gem 'jquery-ui-rails'
gem 'bourbon'
gem 'nokogiri'
gem 'sanitize'
gem 'deface'
gem 'chosen-rails'

# PDF Export
#gem "doc_raptor"

# Excel
#gem 'roo'

# Performances
gem 'thin'

# Refinery CMS
gem 'refinerycms', '~> 2.0.8'
gem 'refinerycms-i18n', '~> 2.0.0'
gem 'refinerycms-midas', :path => 'vendor/extensions'
