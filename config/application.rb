require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module SistemaMensagemApp
  class Application < Rails::Application
    config.load_defaults 7.0
    config.eager_load_paths += %W(#{config.root}/app/jobs)
  end
end
