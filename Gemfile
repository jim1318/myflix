source 'https://rubygems.org'
ruby '2.3.4'

gem 'bootstrap-sass', '3.1.1.1'
gem 'coffee-rails'
gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'pg'



#Jim added
gem 'bootstrap_form'
gem 'bcrypt-ruby'
gem 'turbolinks'
gem 'fabrication'
gem 'faker'
gem 'sidekiq', '< 5'
gem 'sinatra', require: false
gem 'slim'
gem 'unicorn'
gem 'bundler', '1.14.6'
gem 'carrierwave-aws'
gem 'mini_magick'

group :development do
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'letter_opener'
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails'   #, '2.99'
end

group :test do
  gem 'database_cleaner', '1.4.1'
  gem 'shoulda-matchers', '2.7.0'
  gem 'vcr', '2.9.3'

  #Jim Added
  gem 'capybara'
  gem 'launchy'
  gem 'capybara-email'

end

group :production, :staging do
  gem 'rails_12factor'
  gem 'sentry-raven'                #A client and integration layer for the Sentry error reporting API.
end

