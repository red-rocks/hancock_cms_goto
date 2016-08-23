require "hancock/goto/version"

require "hancock/goto/routes"

# require 'hancock_cms'

require 'mongoid'
require 'mongoid_userstamp'

require 'hancock/goto/configuration'
require 'hancock/goto/engine'
require "hancock/goto/middleware"

module Hancock::Goto
  include Hancock::Plugin

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
