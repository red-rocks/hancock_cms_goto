module Hancock::Goto::Decorators
  module Transfer
    extend ActiveSupport::Concern

    included do
      # if Hancock.rails4?
      #   belongs_to :session, class_name: "MongoidStore::Session", overwrite: true
      # else
      #   belongs_to :session, class_name: "MongoidStore::Session", overwrite: true, optional: true
      # end
      # field :session_data, type: BSON::Binary, overwrite: true

      # def session_data_extract
      #   session_data.data if session_data
      # end
      #
      # def session_data_unpack
      #   Marshal.load(session_data_extract) if session_data
      # end
      #
      # def set_session(_session)
      #   self.session_id = _session.id
      #   self.session_data = BSON::Binary.new(Marshal.dump(_session.to_hash))
      # end

      ############# rails_admin ##############
      # def self.rails_admin_name_synonyms
      #   "".freeze
      # end
      # def self.rails_admin_navigation_icon
      #   ''.freeze
      # end
      #
      # def self.rails_admin_add_fields
      #   [].freeze #super
      # end
      #
      # def self.rails_admin_add_config(config)
      #   #super(config)
      # end
      #
      # def self.admin_can_user_defined_actions
      #   [].freeze
      # end
      # def self.admin_cannot_user_defined_actions
      #   [].freeze
      # end
      # def self.manager_can_user_defined_actions
      #   [].freeze
      # end
      # def self.manager_cannot_user_defined_actions
      #   [].freeze
      # end
      # def self.rails_admin_user_defined_visible_actions
      #   [].freeze
      # end
    end

  end
end
