module Hancock::Goto
  module Models
    module Transfer
      extend ActiveSupport::Concern
      include Hancock::Model

      include Hancock::Goto.orm_specific('Transfer')

      included do
      end

      class_methods do

        def rails_admin_name_synonyms
          "".freeze
        end
        def rails_admin_navigation_icon
          ''.freeze
        end

        # def manager_can_default_actions
        #   # [:show, :read].freeze
        #   super - [:new, :create, :delete, :destroy]
        # end
        def admin_cannot_actions
          [:new, :create].freeze
        end
        def manager_cannot_add_actions
          [:new, :create, :delete, :destroy, :edit, :update].freeze
        end

        def manager_can_add_actions
          ret = []
          ret << :model_settings if Hancock::Goto.config.model_settings_support
          # ret << :model_accesses if Hancock::Goto.config.user_abilities_support
          ret += [:comments, :model_comments] if Hancock::Goto.config.ra_comments_support
          ret.freeze
        end
        def rails_admin_add_visible_actions
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
