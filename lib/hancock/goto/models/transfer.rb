module Hancock::Goto
  module Models
    module Transfer
      extend ActiveSupport::Concern
      include Hancock::Model

      include Hancock::Goto.orm_specific('Transfer')

      include ManualSlug

      included do

        # def self.manager_can_default_actions
        #   # [:show, :read].freeze
        #   super - [:new, :create, :delete, :destroy]
        # end
        def self.manager_cannot_add_actions
          [:new, :create, :delete, :destroy, :edit, :update]
        end

        def self.manager_can_add_actions
          ret = []
          ret << :model_settings if Hancock::Goto.config.model_settings_support
          # ret << :model_accesses if Hancock::Goto.config.user_abilities_support
          ret += [:comments, :model_comments] if Hancock::Goto.config.ra_comments_support
          ret.freeze
        end
        def self.rails_admin_add_visible_actions
          ret = []
          ret << :model_settings if Hancock::Goto.config.model_settings_support
          ret << :model_accesses if Hancock::Goto.config.user_abilities_support
          ret += [:comments, :model_comments] if Hancock::Goto.config.ra_comments_support
          ret.freeze
        end

      end

    end
  end
end
