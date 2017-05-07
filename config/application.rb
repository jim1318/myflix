require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Myflix
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true

    config.assets.enabled = true
    config.generators do |g|
      g.orm :active_record
      g.template_engine :haml
    end
  end
end

Raven.configure do |config|
  config.dsn = 'https://d32e0f7b6515448cbfc400b138552ad5:d00dc9cf922f40b9ad273838a87a1cb7@sentry.io/165816'
  config.attr = 'value'
end


