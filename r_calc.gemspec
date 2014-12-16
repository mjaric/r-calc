# -*- encoding: utf-8 -*-
require File.expand_path('../lib/r_calc/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors = ["Milan Jaric"]
  gem.email = ["milan.jaric@gmail.com"]
  gem.description = %q{Gem defines basic grammar for formula builder and ability to execute formulas to get it results or sum them.}
  gem.summary = %q{Sandboxed formula builder and evaluator (it is not evail ;) )}
  gem.homepage = "https://github.com/mjaric/r-calc"

  gem.files = `git ls-files`.split($\)
  gem.executables = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.name = "r_calc"
  gem.require_paths = ["lib"]
  gem.version = RCalc::VERSION

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  #gem.add_development_dependency "ZenTest"
  #gem.add_development_dependency "autotest-fsevent"
  #gem.add_development_dependency "autotest-growl"
  #gem.add_development_dependency "minitest"
  #gem.add_development_dependency "minitest-spec"
  #gem.add_development_dependency "supermodel"
end
