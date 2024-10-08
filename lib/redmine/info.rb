# frozen_string_literal: true

module ZOGO
  module Info
    class << self
      def app_name; 'ZOGO' end
      def url; 'https://www.zogo.org/' end
      def help_url; 'https://www.zogo.org/guide' end
      def versioned_name; "#{app_name} #{ZOGO::VERSION}" end

      def environment
        s = +"Environment:\n"
        s << [
          ["ZOGO version", ZOGO::VERSION],
          ["Ruby version", "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"],
          ["Rails version", Rails::VERSION::STRING],
          ["Environment", Rails.env],
          ["Database adapter", ActiveRecord::Base.connection.adapter_name],
          ["Mailer queue", ActionMailer::MailDeliveryJob.queue_adapter.class.name],
          ["Mailer delivery", ActionMailer::Base.delivery_method]
        ].map {|info| "  %-30s %s" % info}.join("\n") + "\n"

        theme = Setting.ui_theme.blank? ? 'Default' : Setting.ui_theme.capitalize
        unless Setting.ui_theme.blank?
          theme_js  = (if ZOGO::Themes.theme(Setting.ui_theme).javascripts.include?('theme')
                         ' (includes JavaScript)'
                       else
                         ''
                       end
                      )
        end
        theme_string = (theme + theme_js.to_s).to_s

        s << "ZOGO settings:\n"
        s << [
          ["ZOGO theme", theme_string]
        ].map {|settings| "  %-30s %s" % settings}.join("\n") + "\n"

        s << "SCM:\n"
        ZOGO::Scm::Base.all.each do |scm|
          scm_class = "Repository::#{scm}".constantize
          if scm_class.scm_available
            s << "  %-30s %s\n" % [scm, scm_class.scm_version_string]
          end
        end

        s << "ZOGO plugins:\n"
        plugins = ZOGO::Plugin.all
        if plugins.any?
          s << plugins.map {|plugin| "  %-30s %s" % [plugin.id.to_s, plugin.version.to_s]}.join("\n")
        else
          s << "  no plugin installed"
        end
      end
    end
  end
end
