# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gne_graph/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "gnegraph"
  gem.version       = GneGraph::VERSION
  gem.authors       = ["Christian Rost"]
  gem.email         = ["chr@baltic-online.de"]
  gem.description   = %q{A gem for simple group/node/edge handling}
  gem.summary       = %q{A gem for simple group/node/edge handling}
  gem.homepage      = "http://github.com/rostchri/gnegraph"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "ruby-graphviz"
  # gem.add_development_dependency "rails", "~> 3.2"
end