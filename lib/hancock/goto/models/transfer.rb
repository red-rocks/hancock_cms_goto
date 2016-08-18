module Hancock::Goto
  module Models
    module Transfer
      extend ActiveSupport::Concern
      include Hancock::Model

      include Hancock::Goto.orm_specific('Transfer')

      include ManualSlug

      included do
      end

      def self.manager_default_actions
        [:read]
      end
    end
  end
end
