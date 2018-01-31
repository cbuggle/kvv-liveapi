# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'kvv-liveapi/version'

Gem::Specification.new do |s|
  s.name          = "kvv-liveapi"
  s.version       = Kvv::Liveapi::VERSION
  s.authors       = ["Christian Buggle"]
  s.email         = ["christian@buggle.net"]
  s.homepage      = "https://github.com//kvv-liveapi"
  s.summary       = "KVV Live API (Karlsruhe Transport Agency)"
  s.description   = "A simple adapter to query the KVV API (Karlsruher Verkehrsverbund - Karlsruhe Transport Agency) for live timetables ans stop information"

  s.files         = `git ls-files app lib`.split("\n")
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']
end
