# encoding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "kvv/liveapi/version"

Gem::Specification.new do |spec|
  spec.name          = "kvv-liveapi"
  spec.version       = KVV::Liveapi::VERSION
  spec.licenses      = ['MIT']

  spec.authors       = ["Christian Buggle"]
  spec.email         = ["christian@buggle.net"]

  spec.homepage      = "https://github.com//kvv-liveapi"
  spec.summary       = "KVV Live API (Karlsruhe Transport Agency)"
  spec.description   = "A simple adapter to query the KVV API (Karlsruher Verkehrsverbund - Karlsruhe Transport Agency) for live timetable data and stop information"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", '~> 1.16'
  spec.add_development_dependency "rake", '~> 12.3'

  spec.add_development_dependency "minitest", '~> 5.11'
  spec.add_development_dependency "minitest-vcr", '~> 1.4'
  spec.add_development_dependency "minitest-reporters", "~> 1.1"
  spec.add_development_dependency 'webmock', '~> 3.3'
  spec.add_development_dependency "simplecov", '~> 0.15'

  spec.add_development_dependency 'listen', '>= 3.0.5', '< 3.2'
  spec.add_development_dependency 'spring', '~> 2.0'
  spec.add_development_dependency 'spring-watcher-listen', '~> 2.0'
end

