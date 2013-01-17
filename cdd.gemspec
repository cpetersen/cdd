# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cdd/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Christopher Petersen"]
  gem.email         = ["christopher.petersen@gmail.com"]
  gem.description   = %q{A ruby wrapper for CDD's API}
  gem.summary       = %q{Collaborative Drug Discovery is a web based tool for storing and sharing pharmaceutical research. This is a ruby wrapper for their API.}
  gem.homepage      = "http://github.com/cpetersen/cdd"

  gem.add_dependency('json')
  gem.add_dependency('rest-client')
  gem.add_development_dependency('rake')
  gem.add_development_dependency('rspec')

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cdd"
  gem.require_paths = ["lib"]
  gem.version       = CDD::VERSION
end
