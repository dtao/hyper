# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hyper/version'

Gem::Specification.new do |spec|
  spec.name          = "hyper"
  spec.version       = Hyper::VERSION
  spec.authors       = ["Dan Tao"]
  spec.email         = ["daniel.tao@gmail.com"]
  spec.description   = %q{Hyper lets you create a full Rails app in no time, just by defining your domain in a YAML file}
  spec.summary       = %q{Define your domain, get a full Rails app}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "activesupport"
  spec.add_development_dependency "mustache"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
end
