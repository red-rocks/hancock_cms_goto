module Hancock
  module Goto
    include Hancock::PluginConfiguration

    def self.config_class
      Configuration
    end

    def self.configure
      yield configuration
    end

    class Configuration

      attr_accessor :css_selector
      attr_accessor :href_regex
      attr_accessor :excluded_hosts

      attr_accessor :add_nofollow
      attr_accessor :add_noindex
      attr_accessor :add_noreferrer
      attr_accessor :add_noopener
      attr_accessor :del_attrs

      attr_accessor :model_settings_support
      attr_accessor :user_abilities_support
      attr_accessor :ra_comments_support

      def initialize
        @css_selector = "a[href]"
        @href_regex = /^(https?:)?\/\//i
        @excluded_hosts = []

        @add_nofollow = true
        @add_noindex = true
        @add_noreferrer = true
        @add_noopener = true
        @del_attrs = true

        @model_settings_support = defined?(RailsAdminModelSettings)
        @user_abilities_support = defined?(RailsAdminUserAbilities)
        @ra_comments_support = defined?(RailsAdminComments)
      end
    end
  end
end
