ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # tests/test_helper.rb
  # This is for Capybara-email
  ActionDispatch::IntegrationTest
    Capybara.server_port = 3001
    Capybara.app_host = 'http://localhost:3001'
  end

  Sidekiq::Testing.inline!

end
