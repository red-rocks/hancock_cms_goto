module Hancock::Goto
  class Transfer
    include Hancock::Goto::Models::Transfer

    include Hancock::Goto::Decorators::Transfer

    rails_admin(&Hancock::Goto::Admin::Transfer.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
