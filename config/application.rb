require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

ENV.update YAML.load_file('config/app_config.yml')[Rails.env] rescue {}

module Trackdons
  class Application < Rails::Application
    config.load_defaults 5.0

    config.time_zone = 'Madrid'

    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}").to_s]
    config.i18n.available_locales = [:en, :es]
    config.i18n.default_locale = :es

    config.generators do |g|
      g.orm             :active_record
      g.template_engine :erb
      g.test_framework  :rspec, fixture: false
    end

    config.action_mailer.default_url_options = { host: 'trackdons.org' }
  end
end
