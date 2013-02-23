# -*- encoding: utf-8 -*-
require File.expand_path('../lib/formulator/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors = ["Milan Jaric"]
  gem.email = ["milan.jaric@gmail.com"]
  gem.description = %q{Gem defines basic grammar for formula builder and ability to execute formulas to get it results or sum them.}
  gem.summary = %q{Sandboxed formula builder and evaluator}
  gem.homepage = "https://github.com/mjaric/formulator"

  gem.files = `git ls-files`.split($\)
  gem.executables = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.name = "formulator"
  gem.require_paths = ["lib"]
  gem.version = Formulator::VERSION

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "supermodel"
end
