# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'form_relayer/version'

Gem::Specification.new do |spec|
  spec.name          = "form_relayer"
  spec.version       = FormRelayer::VERSION
  spec.authors       = ['GoodLife', 'lulalala']
  spec.email         = ["mark@goodlife.tw"]
  spec.summary       = %q{Makes it easier to make confirmation page by relaying received POST params for further POSTing}
  spec.description   = %q{Makes it easier to relay received POST params for further POSTing. This is ideal if you want to insert an intermediate page during POSTing, such as an order confirmation page.}
  spec.homepage      = 'https://github.com/GoodLife/form_relayer'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", '~> 3.1'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", '~> 10.3'
  spec.add_development_dependency 'rubygems-tasks', '~> 0.2'
  spec.add_development_dependency 'mocha', '~> 1.0.0'
end
