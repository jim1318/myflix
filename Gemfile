source 'https://rubygems.org'
ruby '2.3.4'

gem 'rails', '4.1.1'                 #RAILS TEMPLATE - Rails
gem 'coffee-rails'                   #RAILS TEMPLATE - Use coffes scripts for assets & views
gem 'sass-rails'                     #RAILS TEMPLATE - Use SCSS for stylesheets
gem 'uglifier'                       #RAILS TEMPLATE - Compress javascript files
gem 'jquery-rails'                   #RAILS TEMPLATE - Use jquery as javscript library
gem 'turbolinks'                     #RAILS TEMPLATE - Makes navigating faster

gem 'bootstrap-sass', '3.1.1.1'      #CSS - BOOTSTRAP
gem 'haml-rails'                     #CSS - HAML
gem 'pg'                             #SERVER - Postgress


#Jim added
gem 'bootstrap_form'                #CSS - Bootstrap Forms
gem 'slim'                          #CSS - Templateing Engine : DO WE REALLY NEED THIS????
gem 'bcrypt-ruby'                   #PASSWORDS
gem 'sidekiq', '< 5'                #BACKGROUND JOBS
gem 'sinatra', require: false       #DSL - DO WE REALLY NEED THIS????????
gem 'unicorn'                       #SERVER - multiple processes
gem 'bundler', '1.14.6'             #ORANGIZE - Handle bundled Gems

gem 'carrierwave-aws'               #UPLOAD - upload 
gem 'mini_magick'                   #UPLOAD - manipulate images

gem 'stripe'                        #PAYMENTS - STRIPE
gem 'figaro'                        #PAYMENTS - For storing stripe ENV variables
gem 'stripe_event'                  #PAYMENTS - For handling stripe webhooks

gem 'draper'                        #Used for Decorators

gem 'elasticsearch-model'           #SEARCH - for elastic search
gem 'elasticsearch-rails'           #SEARCH - for elastic search


group :development do
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'letter_opener'
end

group :development, :test do
  gem 'pry'                         #for prying
  gem 'pry-nav'                     #for prying
  gem 'rspec-rails'   #, '2.99'     #for testing
  gem 'fabrication'                 #TESTING - fabricate objects
  gem 'faker'                       #TESTING - fake model data
  gem 'selenium-webdriver'          #used in testing stripe
  gem 'capybara-webkit', '1.12.0'   #used in testing stripe
end

group :test do
  gem 'database_cleaner', '1.4.1'
  gem 'shoulda-matchers', '2.7.0'
  gem 'vcr'                          #for cahcing http API tests
  gem 'webmock'                      #required for vcr
  gem 'capybara'
  gem 'capybara-email'
  gem 'launchy'
  gem 'stripe-ruby-mock', '~> 2.4.1', :require => 'stripe_mock'  #mock up stripe objecst
end

group :production, :staging do
  gem 'rails_12factor'
  gem 'sentry-raven'                #A client and integration layer for the Sentry error reporting API.
end

