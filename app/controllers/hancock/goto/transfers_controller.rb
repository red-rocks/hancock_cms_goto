module Hancock::Goto
  class TransfersController < ApplicationController
    include Hancock::Goto::Controllers::Transfers

    include Hancock::Goto::Decorators::Transfers
  end
end
