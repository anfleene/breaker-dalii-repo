# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'breaker/rails_cache/version'

Gem::Specification.new do |spec|
  spec.name          = "breaker-rails-cache-repo"
  spec.version       = Breaker::RailsCache::VERSION
  spec.authors       = ["Andy Fleener"]
  spec.email         = ["andrew.fleener@sportngin.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = %q{This gem is a memcached implementation of the repo pattern used by the breaker gem}
  spec.description   = %q{Rails Cache backed repo for the breaker gem}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "breaker"
  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
