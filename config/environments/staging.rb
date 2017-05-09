Myflix::Application.configure do

  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_assets = false

  config.assets.compress = true
  config.assets.js_compressor = :uglifier

  config.assets.compile = false

  config.assets.digest = true

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify


  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { host: 'https://dry-peak-19377.herokuapp.com' }

  ActionMailer::Base.smtp_settings = {
  :port           => ENV['MAILGUN_SMTP_PORT'],
  :address        => ENV['MAILGUN_SMTP_SERVER'],
  :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
  :password       => ENV['MAILGUN_SMTP_PASSWORD'],
  :domain         => 'dry-peak-19377.heroku.com',
  :authentication => :plain,
  }
  ActionMailer::Base.delivery_method = :smtp

  #Added for Sentry monitoring
  Raven.configure do |config|
    config.dsn = 'https://d32e0f7b6515448cbfc400b138552ad5:d00dc9cf922f40b9ad273838a87a1cb7@sentry.io/165816'
  end


end