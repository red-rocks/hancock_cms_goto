require 'rails/generators'

module Hancock::Goto::Models
  class DecoratorsGenerator < Rails::Generators::Base
    source_root File.expand_path('../../../../../../app/models/concerns/hancock/goto/decorators', __FILE__)
    argument :Models, type: :array, default: []

    desc 'Hancock::Goto Models decorators generator'
    def decorators
      copied = false
      (models == ['all'] ? permitted_models : models & permitted_models).each do |c|
        copied = true
        copy_file "#{c}.rb", "app/models/concerns/hancock/goto/decorators/#{c}.rb"
      end
      puts "U need to set controller`s name. One of this: #{permitted_models.join(", ")}." unless copied
    end

    private
    def permitted_models
      ['transfer']
    end

  end
end
