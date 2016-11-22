require 'rails/generators'

module Hancock::Goto
  class ConfigGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Hancock::Goto Config generator'
    def config
      template 'hancock_goto.erb', "config/initializers/hancock_goto.rb"
    end

  end
end
