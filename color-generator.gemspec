# -*- encoding: utf-8 -*-
require File.expand_path('../lib/color-generator/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "color-generator"
  s.version     = ColorGenerator::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Open North"]
  s.email       = ["info@opennorth.ca"]
  s.homepage    = "http://github.com/opennorth/color-generator"
  s.summary     = %q{Randomly generate distinct colors with consistent lightness and saturation}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency('rspec', '~> 2.10')
  s.add_development_dependency('rake')
  s.add_development_dependency('coveralls')
end
