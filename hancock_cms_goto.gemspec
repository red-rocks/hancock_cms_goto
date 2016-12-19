# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hancock/goto/version'

Gem::Specification.new do |spec|
  spec.name          = "hancock_cms_goto"
  spec.version       = Hancock::Goto::VERSION
  spec.authors       = ["Alexander Kiseliev"]
  spec.email         = ["dev@redrocks.pro"]

  spec.summary       = %q{URL redirect dispatcher with HancockCMS support.}
  spec.description   = %q{URL redirect dispatcher with HancockCMS support.}
  spec.homepage      = "https://github.com/red-rocks/hancock_cms_goto"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency 'hancock_cms', [">=1.0.1", "<=2.1"]
  # spec.add_dependency 'hancock_cms', ["~> 1.0", "~> 2.1"]

  spec.add_dependency 'nokogiri'
  spec.add_dependency 'addressable'
end
