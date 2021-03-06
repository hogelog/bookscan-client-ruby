# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bookscan_client/version'

Gem::Specification.new do |spec|
  spec.name          = "bookscan_client"
  spec.version       = BookscanClient::VERSION
  spec.authors       = ["hogelog"]
  spec.email         = ["konbu.komuro@gmail.com"]
  spec.summary       = %q{Unofficial bookscan client.}
  spec.description   = %q{Unofficial bookscan client library for ruby}
  spec.homepage      = "https://github.com/hogelog/bookscan-client-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "mechanize", "2.7.2"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "minitest"
end
