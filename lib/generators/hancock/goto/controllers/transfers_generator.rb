require 'rails/generators'

module Hancock::Goto::Controllers
  class TransfersGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    argument :class_name_arg, type: :string, default: ""

    desc 'Hancock::Goto Transfer Controller generator'
    def transfers
      template 'transfers.erb', "app/controllers/#{file_name}.rb"
    end

    private
    def class_name
      class_name_arg.blank? ? "SetClassForTransferController" : class_name_arg
    end

    def capitalized_class_name
      class_name.capitalize
    end

    def camelcased_class_name
      class_name.camelcase
    end

    def file_name
      underscored_class_name
    end

    def underscored_class_name
      camelcased_class_name.underscore
    end

    def underscored_pluralized_class_name
      underscored_class_name.pluralize
    end

  end
end
