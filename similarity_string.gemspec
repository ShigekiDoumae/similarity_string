# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'similarity_string/version'

Gem::Specification.new do |gem|
  gem.name          = "similarity_string"
  gem.version       = SimilarityString::VERSION
  gem.authors       = ["Shigeki Doumae"]
  gem.email         = ["shigeki.doumae+similarity_string@gmail.com"]
  gem.description   = %q{similarity of string}
  gem.summary       = %q{similarity of string}
  gem.homepage      = "https://github.com/ShigekiDoumae"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
