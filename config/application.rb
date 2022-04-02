# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module ProjectStore
  class Application < Rails::Application
    config.load_defaults 6.1
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '/*.yml')]
    config.i18n.default_locale = :en # (note that `en` is already the default!)
    config.i18n.available_locales = %i[en ru]
    config.time_zone = 'Moscow'
  end
end
