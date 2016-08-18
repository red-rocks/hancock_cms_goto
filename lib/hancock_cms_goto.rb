require "hancock/goto/version"

require "hancock/goto/routes"

# require 'hancock_cms'

require 'mongoid'
require 'mongoid_userstamp'

require 'hancock/goto/configuration'
require 'hancock/goto/engine'
require "hancock/goto/middleware"

module Hancock
  module Goto
    class << self
      def orm
        :mongoid #Hancock.orm
      end
      def mongoid?
        Hancock::Goto.orm == :mongoid
      end
      def active_record?
        Hancock::Goto.orm == :active_record
      end
      def model_namespace
        "Hancock::Goto::Models::#{Hancock::Goto.orm.to_s.camelize}"
      end
      def orm_specific(name)
        "#{model_namespace}::#{name}".constantize
      end
    end

    autoload :Admin, 'hancock/goto/admin'
    module Admin
      autoload :Transfer, 'hancock/goto/admin/transfer'
    end

    module Models
      autoload :Transfer, 'hancock/goto/models/transfer'

      module Mongoid
        autoload :Transfer, 'hancock/goto/models/mongoid/transfer'
      end
    end

    module Controllers
      autoload :Transfers, 'hancock/goto/controllers/transfers'
    end

  end
end
