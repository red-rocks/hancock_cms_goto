module Hancock::Goto
  module Models
    module Transfer
      extend ActiveSupport::Concern
      include Hancock::Model

      include Hancock::Goto.orm_specific('Transfer')

      include ManualSlug

      included do

        def self.manager_can_add_actions
          [:read]
        end
        def self.rails_admin_add_visible_actions
          []
        end
        
      end

    end
  end
end
