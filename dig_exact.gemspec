# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dig_exact/version'

Gem::Specification.new do |spec|
  spec.name          = "dig_exact"
  spec.version       = DigExact::VERSION
  spec.authors       = ["fangxing"]
  spec.email         = ["fangxing204@gmail.com"]

  spec.summary       = %q{#dig_exact return nil instead of raise Klass does not have #dig method TypeError}
  spec.homepage      = "https://github.com/fffx/dig_exact"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  #spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 12"
  spec.add_development_dependency "minitest", "~> 5.11"
end
