require 'rails/generators'

module Hancock::Goto::Controllers
  class DecoratorsGenerator < Rails::Generators::Base
    source_root File.expand_path('../../../../../../app/controllers/concerns/hancock/goto/decorators', __FILE__)
    argument :controllers, type: :array, default: []

    desc 'Hancock::Goto Controllers decorators generator'
    def decorators
      copied = false
      (controllers == ['all'] ? permitted_controllers : controllers & permitted_controllers).each do |m|
        copied = true
        copy_file "#{m}.rb", "app/controllers/concerns/hancock/goto/decorators/#{m}.rb"
      end
      puts "U need to set controllers`s name. One of this: #{permitted_controllers.join(", ")}." unless copied
    end

    private
    def permitted_controllers
      ['transfers']
    end

  end
end
