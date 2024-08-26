# frozen_string_literal: true

require 'zogo/configuration'
require 'zogo/plugin_loader'

Rails.application.config.to_prepare do
  I18n.backend = ZOGO::I18n::Backend.new
  # Forces I18n to load available locales from the backend
  I18n.config.available_locales = nil

  ZOGO::Preparation.prepare
end

# Load the secret token from the ZOGO configuration file
secret = ZOGO::Configuration['secret_token']
if secret.present?
  ZOGOApp::Application.config.secret_token = secret
end

ZOGO::PluginLoader.load
plugin_assets_reloader = ZOGO::PluginLoader.create_assets_reloader

Rails.application.reloaders << plugin_assets_reloader
unless ZOGO::Configuration['mirror_plugins_assets_on_startup'] == false
  plugin_assets_reloader.execute
end

Rails.application.config.to_prepare do
  ZOGO::FieldFormat::RecordList.subclasses.each do |klass|
    klass.instance.reset_target_class
  end

  plugin_assets_reloader.execute_if_updated
end
