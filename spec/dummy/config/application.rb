require_relative 'boot'

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "action_mailer/railtie"
require "active_job/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)
require "oh_sheet"

module Dummy
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Execute jobs right away
    config.active_job.queue_adapter = :inline
  end
end

