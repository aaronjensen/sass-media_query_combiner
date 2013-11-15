# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sass/media_query_combiner/version'

Gem::Specification.new do |gem|
  gem.name          = "sass-media_query_combiner"
  gem.version       = Sass::MediaQueryCombiner::VERSION
  gem.authors       = ["Aaron Jensen"]
  gem.email         = ["aaronjensen@gmail.com"]
  gem.description   = %q{Automatically combine media queries}
  gem.summary       = %q{Sass plugin to combine all like media queries}
  gem.homepage      = ""
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.required_ruby_version = '>= 1.9.2'

  gem.add_runtime_dependency "sass", ">=3.2.0"

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rake"
end
